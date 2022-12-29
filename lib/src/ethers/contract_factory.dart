part of ethers;

class ContractFactory extends Interop<_ContractFactoryImpl> {
  factory ContractFactory(
      dynamic abi, String bytecode, dynamic providerOrSigner) {
    assert(
      providerOrSigner is Web3Provider ||
          providerOrSigner is JsonRpcProvider ||
          providerOrSigner is Provider ||
          providerOrSigner is Signer,
      'providerOrSigner must be Provider or Signer',
    );
    assert(
      abi is String || abi is List<String> || abi is Interface,
      'abi must be valid type',
    );

    return ContractFactory._(_ContractFactoryImpl(
        abi is Interface ? abi.impl : abi,
        bytecode,
        (providerOrSigner as Interop).impl));
  }

  /// Instantiate [Contract] from [provider] for read-only contract calls.
  factory ContractFactory.fromProvider(
          dynamic abi, String bytecode, Provider provider) =>
      ContractFactory._(_ContractFactoryImpl(abi, bytecode, provider.impl));

  /// Instantiate [Contract] from [provider] for read-write contract calls.
  factory ContractFactory.fromSigner(
          dynamic abi, String bytecode, Signer signer) =>
      ContractFactory._(_ContractFactoryImpl(abi, bytecode, signer.impl));

  const ContractFactory._(_ContractFactoryImpl impl) : super.internal(impl);

  Interface get interface => impl.interface;
  String get bytecode => impl.bytecode;
  Signer? get signer => impl.signer != null ? Signer._(impl.signer!) : null;

  ContractFactory connect(dynamic providerOrSigner) {
    assert(
      providerOrSigner is Web3Provider ||
          providerOrSigner is JsonRpcProvider ||
          providerOrSigner is Provider ||
          providerOrSigner is Signer,
      'providerOrSigner must be Provider or Signer',
    );

    return ContractFactory._(impl.connect((providerOrSigner as Interop).impl));
  }

  Future<Contract> deploy(String arg1, String arg2,
          [TransactionOverride? override]) async =>
      Contract._(await promiseToFuture<_ContractImpl>(impl.deploy(arg1, arg2)));
}
