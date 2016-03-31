#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "nginx.docker";
    .port = "80";
}

acl purge {
  "localhost";
  "enviroment_php55_1.enviroment.docker";
  "enviroment_php56_1.enviroment.docker";
  "enviroment_php70_1.enviroment.docker";
  "nginx.docker";
}

sub vcl_recv {
//  set req.backend_hint = bar.backend(); ???

  # Check the incoming request type is "PURGE", not "GET" or "POST"
  if (req.method == "PURGE") {
    # Check if the ip coresponds with the acl purge
    if (!client.ip ~ purge) {
      # Return error code 405 (Forbidden) when not
      return (synth(405, "Not allowed."));
    }
    return (purge);
  }

  if (req.restarts == 0) {
    if (req.http.X-Real-IP) {
      set req.http.X-Forwarded-For = req.http.X-Real-IP;
    }
    else if (req.http.x-forwarded-for) {
      set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
    }
    else {
      set req.http.X-Forwarded-For = client.ip;
    }
  }

  # Do not cache these paths.
  if (req.url ~ "^/status\.php$" ||
      req.url ~ "^/update\.php" ||
      req.url ~ "^/install\.php" ||
      req.url ~ "^/apc\.php$" ||
      req.url ~ "^/admin" ||
      req.url ~ "^/admin/.*$" ||
      req.url ~ "^/user" ||
      req.url ~ "^/user/.*$" ||
      req.url ~ "^/users/.*$" ||
      req.url ~ "^/info/.*$" ||
      req.url ~ "^/flag/.*$" ||
      req.url ~ "^.*/ajax/.*$" ||
      req.url ~ "^.*/ahah/.*$") {

    return (pass);
  }

  # Always cache the following file types for all users. This list of extensions
  # appears twice, once here and again in vcl_fetch so make sure you edit both
  # and keep them equal.
  if (req.url ~ "(?i)\.(pdf|asc|dat|txt|doc|xls|ppt|tgz|csv|png|gif|jpeg|jpg|ico|swf|css|js)(\?.*)?$") {
    unset req.http.Cookie;
  }

  # Remove all cookies that Drupal doesn't need to know about. We explicitly
  # list the ones that Drupal does need, the SESS and NO_CACHE. If, after
  # running this code we find that either of these two cookies remains, we
  # will pass as the page cannot be cached.
  if (req.http.Cookie) {
    # 1. Append a semi-colon to the front of the cookie string.
    # 2. Remove all spaces that appear after semi-colons.
    # 3. Match the cookies we want to keep, adding the space we removed
    #    previously back. (\1) is first matching group in the regsuball.
    # 4. Remove all other cookies, identifying them by the fact that they have
    #    no space after the preceding semi-colon.
    # 5. Remove all spaces and semi-colons from the beginning and end of the
    #    cookie string.
    set req.http.Cookie = ";" + req.http.Cookie;
    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE)=", "; \1=");
    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

    if (req.http.Cookie == "") {
      # If there are no remaining cookies, remove the cookie header. If there
      # aren't any cookie headers, Varnish's default behavior will be to cache
      # the page.
      unset req.http.Cookie;
    }
    else {
      # If there is any cookies left (a session or NO_CACHE cookie), do not
      # cache the page. Pass it on to Apache directly.
      return (pass);
    }
  }
}

sub vcl_hash {
    hash_data(req.url);
}


sub vcl_deliver {
    if (obj.hits > 0) {
       set resp.http.X-Cache = "HIT";
    } else {
       set resp.http.X-Cache = "MISS";
    }
}

sub vcl_backend_response {
    set beresp.do_esi = true; // Do ESI processing

//    if (bereq.url == "/test.html") {
//       set beresp.ttl = 24 h;    // Sets the TTL on the HTML above
//    } elseif (bereq.url == "/cgi-bin/date.cgi") {
//       set beresp.ttl = 1m;      // Sets a one minute TTL on
//                                 // the included object
//    }
}