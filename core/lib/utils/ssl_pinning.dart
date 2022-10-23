import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class IOClientWithSSL {
  IOClientWithSSL();

  Future<SecurityContext> globalContext() async {
    final sslCert =
        await rootBundle.load('assets/certificates/themoviedb.org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<IOClient> getIOClient() async {
    HttpClient client = HttpClient(context: await globalContext());
    client.badCertificateCallback = (cert, host, port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return await getIOClient()
        .then((ioClient) => ioClient.get(url, headers: headers));
  }
}
