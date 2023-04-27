import 'package:json_annotation/json_annotation.dart';

part 'bse_basis_set.g.dart';

/// A single basis set from [Basis Set Exchange](https://www.basissetexchange.org).
@JsonSerializable()
class BseBasisSet {
  /// Constructor for a [BseBasisSet] object.
  const BseBasisSet({
    required this.name,
    required this.description,
    required this.version,
    required this.revisionDescription,
    required this.revisionDate,
    required this.family,
    required this.functionTypes,
    required this.role,
    required this.auxiliaries,
    required this.elements
  });

  /// Constructor of [BseBasisSet] object from JSON.
  factory BseBasisSet.fromJson(Map<String, dynamic> json) =>
    _$BseBasisSetFromJson(json);

  /// Canonical name for this basis set.
  final String name;

  /// Brief description of the basis set.
  final String description;

  /// Version of the basis set.
  final String version;

  /// Brief description of the difference between this revision and the last.
  @JsonKey(name: 'revision_description')
  final String revisionDescription;

  /// The date when this revision was finalized/uploaded.
  @JsonKey(name: 'revision_date')
  final String revisionDate;

  /// Data for the elements of the basis set.
  @JsonKey(name: 'elements')
  final Map<String, ElementBasisSet> elements;

  /// Broad family that the basis set is from.
  final String family;

  /// A list of function types in a basis set.
  @JsonKey(name: 'function_types')
  final Set<String> functionTypes;

  /// Role that this basis plays in a calculation.
  final String role;

  /// Auxiliary basis sets (fitting, etc) and how their role with this basis.
  final Map<String, String> auxiliaries;
}

/// Data for a single element or atom in the basis set.
@JsonSerializable()
class ElementBasisSet {
  /// Constructor for a [ElementBasisSet] object.
  const ElementBasisSet({
    this.electronShells,
    this.ecpElectrons,
    this.ecpPotentials,
    required this.references
  });

  /// Constructor of [ElementBasisSet] object from JSON.
  factory ElementBasisSet.fromJson(Map<String, dynamic> json) =>
    _$ElementBasisSetFromJson(json);

  /// A list of (electronic) shells.
  @JsonKey(name: 'electron_shells', includeIfNull: false)
  final List<ElectronShell>? electronShells;

  /// Number of electrons replaced by ECP.
  @JsonKey(name: 'ecp_electrons', includeIfNull: false)
  final int? ecpElectrons;

  /// A list of Effective Core Potentials (ECPs).
  @JsonKey(name: 'ecp_potentials', includeIfNull: false)
  final List<EcpPotential>? ecpPotentials;

  /// Citation/Reference data (including descriptions) pertaining to some basis set data.
  final List<ReferenceMap> references;
}

/// Citation/Reference data (including descriptions) pertaining to some basis set data.
@JsonSerializable()
class ReferenceMap {
  /// Constructor for a [ReferenceMap] object.
  const ReferenceMap({
    required this.description,
    required this.keys
  });

  /// Constructor of [ReferenceMap] object from JSON.
  factory ReferenceMap.fromJson(Map<String, dynamic> json) =>
    _$ReferenceMapFromJson(json);

  /// A description of what this reference pertains to.
  @JsonKey(name: 'reference_description')
  final String description;

  /// Citation/Reference keys pertaining to some basis set data.
  @JsonKey(name: 'reference_keys')
  final List<String> keys;
}

/// Information for a single electronic shell.
@JsonSerializable()
class ElectronShell {
  /// Constructor for a [ElectronShell] object.
  const ElectronShell({
    required this.functionType,
    required this.region,
    required this.angularMomentum,
    required this.exponents,
    required this.coefficients
  });

  /// Constructor of [ElectronShell] object from JSON.
  factory ElectronShell.fromJson(Map<String, dynamic> json) =>
    _$ElectronShellFromJson(json);

  /// Type of function for an electron shell.
  @JsonKey(name: 'function_type')
  final String functionType;

  /// The region an electron shell describes.
  final String region;

  /// Angular momentum (as an array of integers).
  @JsonKey(name: 'angular_momentum')
  final List<int> angularMomentum;

  /// Exponents for this contracted shell.
  final List<String> exponents;

  /// General contraction coefficients for this contracted shell, and each
  /// iterm represents segmented contraction coefficients.
  final List<List<String>> coefficients;
}

/// ECP potential.
@JsonSerializable()
class EcpPotential {
  /// Constructor for a [EcpPotential] object.
  const EcpPotential({
    required this.ecpType,
    required this.angularMomentum,
    required this.rExponents,
    required this.gaussianExponents,
    required this.coefficients
  });

  /// Constructor of [EcpPotential] object from JSON.
  factory EcpPotential.fromJson(Map<String, dynamic> json) =>
    _$EcpPotentialFromJson(json);

  /// Type of the ECP potential.
  @JsonKey(name: 'ecp_type')
  final String ecpType;

  /// Angular momentum (as an array of integers).
  @JsonKey(name: 'angular_momentum')
  final List<int> angularMomentum;

  /// Exponents of the r term.
  @JsonKey(name: 'r_exponents')
  final List<int> rExponents;

  /// Exponents of the gaussian term.
  @JsonKey(name: 'gaussian_exponents')
  final List<String> gaussianExponents;

  /// General contraction coefficients for this contracted shell, and each
  /// iterm represents segmented contraction coefficients.
  final List<List<String>> coefficients;
}
