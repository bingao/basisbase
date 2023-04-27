import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/models.dart';
import 'errors.dart';

/// The base URL for querying basis sets
const _defaultBaseUrl = 'www.basissetexchange.org';

///
class BasisSetExchange {
  final http.Client? _client;
  final String _scheme;
  final String _baseUrl;

  BasisSetExchange({
    http.Client? client,
    String scheme = 'https',
    String baseUrl = _defaultBaseUrl
  }) : _client = client,
       _scheme = scheme,
       _baseUrl = baseUrl;

  Future<http.Response> _get(String path, {Map<String, dynamic>? queryParameters}) {
    final uri = Uri(
      scheme: _scheme,
      host: _baseUrl,
      path: path,
      queryParameters: queryParameters
    );
    //print(uri);
    return _client?.get(uri) ?? http.get(uri);
  }

  /// Return a list of all basis set names.
  //Future<List<String>> getMetadata() async {
  void getMetadata() async {
    final response = await _get('/api/metadata');
    if (response.statusCode!=HttpStatus.ok) throw BasisSetRequestFailure();
    //print(response.body);
    //return _decodeBasisNames(response.body);
  }

  Future<BseBasisSet> getBasis(String name, {
    String? elements,
    int? version,
    bool uncontractGeneral = false,
    bool uncontractSPDF = false,
    bool uncontractSegmented = false,
    //bool removeFreePrimitives = false,
    bool makeGeneral = false,
    bool optimizeGeneral = false,
    //int augmentDiffuse = 0,
    //int augmentSteep = 0,
    //int getAux = 0
  }) async {
    final response = await _get(
      '/api/basis/$name/format/json/',
      queryParameters: {
        if (elements!=null) 'elements': elements,
        if (version!=null) 'version': version.toString(),
        'uncontract_general': uncontractGeneral.toString(),
        'uncontract_spdf': uncontractSPDF.toString(),
        'uncontract_segmented': uncontractSegmented.toString(),
        'make_general': makeGeneral.toString(),
        'optimize_general': optimizeGeneral.toString(),
        'header': 'false'
      }
    );
    if (response.statusCode!=HttpStatus.ok) throw BasisSetRequestFailure();
    //print(response.body);

    final basisJson = jsonDecode(response.body) as Map<String, dynamic>;
    if (basisJson.isEmpty) throw BasisSetNotFoundFailure();
    print(basisJson);
    return BseBasisSet.fromJson(basisJson);
  }

  //Future<String> getBasisFamily(String name) async {
  //}

  //Future<List<Reference>> getReferences(String name, {
  void getReferences(String name, {
    String? elements,
    int? version
  }) async {
    final response = await _get(
      '/api/references/$name/format/json/',
      queryParameters: {
        if (elements!=null) 'elements': elements,
        if (version!=null) 'version': version.toString(),
      }
    );
    if (response.statusCode!=HttpStatus.ok) throw BasisSetRequestFailure();
    //print(response.body);
    //return
  }

  //get_roles
  //lookup_basis_by_role
}
