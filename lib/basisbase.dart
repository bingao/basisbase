/// basisbase can,
/// - find and read basis set from local Isar database;
/// - if not found, then try to get it from
///   [Basis Set Exchange](https://www.basissetexchange.org) via REST APIs,
///   and save it into local Isar database;
/// - check and update local basis sets against those at Basis Set Exchange

library basisbase;

export 'src/basis_set_exchange.dart';
//export 'src/cascade.dart' show Cascade;
