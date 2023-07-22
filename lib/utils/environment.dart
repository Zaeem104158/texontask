// ignore_for_file: constant_identifier_names

enum Environment {
  STAGING,
  PRODUCTION,
}

const Environment activeProfile = Environment.PRODUCTION;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "https://randomuser.me/api";

    case Environment.PRODUCTION:
      return "https://randomuser.me/api";
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
}
