// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dart_web3/dart_web3.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"approveReport","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"uint8","name":"_plan","type":"uint8"}],"name":"changePlan","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"}],"name":"ClientSuspended","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint256","name":"damagePrice","type":"uint256"}],"name":"CompensationPayment","type":"event"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"uint8","name":"_planNumber","type":"uint8"},{"internalType":"uint32","name":"diff","type":"uint32"}],"name":"confirmHigherPlanSwitchPayment","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"uint256","name":"_value","type":"uint256"}],"name":"confirmMonthlyFeePayment","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint32","name":"_value","type":"uint32"}],"name":"ConfirmPayment","type":"event"},{"inputs":[{"internalType":"address","name":"reviewer","type":"address"},{"internalType":"address","name":"reviewee","type":"address"}],"name":"confirmReport","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint32","name":"reportId","type":"uint32"}],"name":"DamageDeclaration","type":"event"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"pictureHash","type":"string"},{"internalType":"string","name":"documentHash","type":"string"},{"internalType":"uint32","name":"damagePrice","type":"uint32"}],"name":"declareDamage","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"pictureHash","type":"string"},{"internalType":"string","name":"documentHash","type":"string"},{"internalType":"uint32","name":"damagePrice","type":"uint32"}],"name":"declareDamageWithTokens","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"subtractedValue","type":"uint256"}],"name":"decreaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"addedValue","type":"uint256"}],"name":"increaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint8","name":"planNumber","type":"uint8"}],"name":"InsuranceRegistration","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"}],"name":"InsuranceResigned","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint32","name":"_value","type":"uint32"}],"name":"MontlyFeePayment","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"payCompensation","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"payMonthlyFee","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"reviewer","type":"address"},{"internalType":"address","name":"reviewee","type":"address"}],"name":"refuseReport","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint32","name":"reportId","type":"uint32"}],"name":"ReportApproved","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"reviewer","type":"address"},{"indexed":true,"internalType":"uint32","name":"reportId","type":"uint32"}],"name":"ReportConfirmed","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"reviewer","type":"address"},{"indexed":true,"internalType":"uint32","name":"reportId","type":"uint32"}],"name":"ReportRefused","type":"event"},{"inputs":[],"name":"resignInsurance","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"setGatewayAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"suspendClient","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint8","name":"planNumber","type":"uint8"},{"indexed":true,"internalType":"uint32","name":"feeDifference","type":"uint32"}],"name":"SwitchHigherPlan","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_address","type":"address"},{"indexed":true,"internalType":"uint8","name":"utilityTokens","type":"uint8"}],"name":"SwitchLowerPlan","type":"event"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"uint8","name":"_plan","type":"uint8"}],"name":"takeOutInsurance","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"getMonthlyFee","outputs":[{"internalType":"uint32","name":"","type":"uint32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"getNextPaymentDate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"getPlan","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getRandomDamagePicture","outputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"hasInsurance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"hasReport","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"isInsuranceActive","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]',
  'GasInsurance',
);

class GasInsurance extends _i1.GeneratedContract {
  GasInsurance({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> approve(
    _i1.EthereumAddress spender,
    BigInt amount, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '095ea7b3'));
    final params = [
      spender,
      amount,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> approveReport(
    _i1.EthereumAddress _address, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'b6bcd2d8'));
    final params = [_address];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> changePlan(
    _i1.EthereumAddress _address,
    BigInt _plan, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '8586dafb'));
    final params = [
      _address,
      _plan,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmHigherPlanSwitchPayment(
    _i1.EthereumAddress _address,
    BigInt _planNumber,
    BigInt diff, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'f0ab7cac'));
    final params = [
      _address,
      _planNumber,
      diff,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmMonthlyFeePayment(
    _i1.EthereumAddress _address,
    BigInt _value, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'c54e0630'));
    final params = [
      _address,
      _value,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmReport(
    _i1.EthereumAddress reviewer,
    _i1.EthereumAddress reviewee, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'a9bdd930'));
    final params = [
      reviewer,
      reviewee,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> declareDamage(
    _i1.EthereumAddress _address,
    String pictureHash,
    String documentHash,
    BigInt damagePrice, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '5b6d4376'));
    final params = [
      _address,
      pictureHash,
      documentHash,
      damagePrice,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> declareDamageWithTokens(
    _i1.EthereumAddress _address,
    String pictureHash,
    String documentHash,
    BigInt damagePrice, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '0d3bca12'));
    final params = [
      _address,
      pictureHash,
      documentHash,
      damagePrice,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> decreaseAllowance(
    _i1.EthereumAddress spender,
    BigInt subtractedValue, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'a457c2d7'));
    final params = [
      spender,
      subtractedValue,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> increaseAllowance(
    _i1.EthereumAddress spender,
    BigInt addedValue, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '39509351'));
    final params = [
      spender,
      addedValue,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> payCompensation(
    _i1.EthereumAddress _address, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'd95ae721'));
    final params = [_address];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> payMonthlyFee(
    _i1.EthereumAddress _address, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'b14420f9'));
    final params = [_address];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> refuseReport(
    _i1.EthereumAddress reviewer,
    _i1.EthereumAddress reviewee, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '91938ee3'));
    final params = [
      reviewer,
      reviewee,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceOwnership({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '715018a6'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> resignInsurance({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, 'a9df6615'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setGatewayAddress(
    _i1.EthereumAddress _address, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, 'a35ff076'));
    final params = [_address];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> suspendClient(
    _i1.EthereumAddress _address, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, '233ffe71'));
    final params = [_address];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> takeOutInsurance(
    _i1.EthereumAddress _address,
    BigInt _plan, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'e82ea4cd'));
    final params = [
      _address,
      _plan,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transfer(
    _i1.EthereumAddress to,
    BigInt amount, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, 'a9059cbb'));
    final params = [
      to,
      amount,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferFrom(
    _i1.EthereumAddress from,
    _i1.EthereumAddress to,
    BigInt amount, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '23b872dd'));
    final params = [
      from,
      to,
      amount,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferOwnership(
    _i1.EthereumAddress newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, 'f2fde38b'));
    final params = [newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> allowance(
    _i1.EthereumAddress owner,
    _i1.EthereumAddress spender, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, 'dd62ed3e'));
    final params = [
      owner,
      spender,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> balanceOf(
    _i1.EthereumAddress account, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[23];
    assert(checkSignature(function, '70a08231'));
    final params = [account];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> decimals({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[24];
    assert(checkSignature(function, '313ce567'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getMonthlyFee(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[25];
    assert(checkSignature(function, '1311b6f0'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getNextPaymentDate(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[26];
    assert(checkSignature(function, '8c6f5a24'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getPlan(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[27];
    assert(checkSignature(function, '7cb22aaf'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetRandomDamagePicture> getRandomDamagePicture(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[28];
    assert(checkSignature(function, 'a063d358'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetRandomDamagePicture(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> hasInsurance(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[29];
    assert(checkSignature(function, '8cd42316'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> hasReport(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[30];
    assert(checkSignature(function, '73cba239'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isInsuranceActive(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[31];
    assert(checkSignature(function, '7e02a716'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> name({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[32];
    assert(checkSignature(function, '06fdde03'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[33];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> symbol({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[34];
    assert(checkSignature(function, '95d89b41'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> totalSupply({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[35];
    assert(checkSignature(function, '18160ddd'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// Returns a live stream of all Approval events emitted by this contract.
  Stream<Approval> approvalEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Approval');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Approval(decoded);
    });
  }

  /// Returns a live stream of all ClientSuspended events emitted by this contract.
  Stream<ClientSuspended> clientSuspendedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ClientSuspended');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ClientSuspended(decoded);
    });
  }

  /// Returns a live stream of all CompensationPayment events emitted by this contract.
  Stream<CompensationPayment> compensationPaymentEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('CompensationPayment');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return CompensationPayment(decoded);
    });
  }

  /// Returns a live stream of all ConfirmPayment events emitted by this contract.
  Stream<ConfirmPayment> confirmPaymentEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ConfirmPayment');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ConfirmPayment(decoded);
    });
  }

  /// Returns a live stream of all DamageDeclaration events emitted by this contract.
  Stream<DamageDeclaration> damageDeclarationEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('DamageDeclaration');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return DamageDeclaration(decoded);
    });
  }

  /// Returns a live stream of all InsuranceRegistration events emitted by this contract.
  Stream<InsuranceRegistration> insuranceRegistrationEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('InsuranceRegistration');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return InsuranceRegistration(decoded);
    });
  }

  /// Returns a live stream of all InsuranceResigned events emitted by this contract.
  Stream<InsuranceResigned> insuranceResignedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('InsuranceResigned');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return InsuranceResigned(decoded);
    });
  }

  /// Returns a live stream of all MontlyFeePayment events emitted by this contract.
  Stream<MontlyFeePayment> montlyFeePaymentEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('MontlyFeePayment');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return MontlyFeePayment(decoded);
    });
  }

  /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
  Stream<OwnershipTransferred> ownershipTransferredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnershipTransferred');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return OwnershipTransferred(decoded);
    });
  }

  /// Returns a live stream of all ReportApproved events emitted by this contract.
  Stream<ReportApproved> reportApprovedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ReportApproved');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ReportApproved(decoded);
    });
  }

  /// Returns a live stream of all ReportConfirmed events emitted by this contract.
  Stream<ReportConfirmed> reportConfirmedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ReportConfirmed');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ReportConfirmed(decoded);
    });
  }

  /// Returns a live stream of all ReportRefused events emitted by this contract.
  Stream<ReportRefused> reportRefusedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ReportRefused');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ReportRefused(decoded);
    });
  }

  /// Returns a live stream of all SwitchHigherPlan events emitted by this contract.
  Stream<SwitchHigherPlan> switchHigherPlanEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('SwitchHigherPlan');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return SwitchHigherPlan(decoded);
    });
  }

  /// Returns a live stream of all SwitchLowerPlan events emitted by this contract.
  Stream<SwitchLowerPlan> switchLowerPlanEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('SwitchLowerPlan');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return SwitchLowerPlan(decoded);
    });
  }

  /// Returns a live stream of all Transfer events emitted by this contract.
  Stream<Transfer> transferEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Transfer');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Transfer(decoded);
    });
  }
}

class GetRandomDamagePicture {
  GetRandomDamagePicture(List<dynamic> response)
      : var1 = (response[0] as _i1.EthereumAddress),
        var2 = (response[1] as String);

  final _i1.EthereumAddress var1;

  final String var2;
}

class Approval {
  Approval(List<dynamic> response)
      : owner = (response[0] as _i1.EthereumAddress),
        spender = (response[1] as _i1.EthereumAddress),
        value = (response[2] as BigInt);

  final _i1.EthereumAddress owner;

  final _i1.EthereumAddress spender;

  final BigInt value;
}

class ClientSuspended {
  ClientSuspended(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress address;
}

class CompensationPayment {
  CompensationPayment(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        damagePrice = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt damagePrice;
}

class ConfirmPayment {
  ConfirmPayment(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        value = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt value;
}

class DamageDeclaration {
  DamageDeclaration(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        reportId = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt reportId;
}

class InsuranceRegistration {
  InsuranceRegistration(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        planNumber = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt planNumber;
}

class InsuranceResigned {
  InsuranceResigned(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress address;
}

class MontlyFeePayment {
  MontlyFeePayment(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        value = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt value;
}

class OwnershipTransferred {
  OwnershipTransferred(List<dynamic> response)
      : previousOwner = (response[0] as _i1.EthereumAddress),
        newOwner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousOwner;

  final _i1.EthereumAddress newOwner;
}

class ReportApproved {
  ReportApproved(List<dynamic> response) : reportId = (response[0] as BigInt);

  final BigInt reportId;
}

class ReportConfirmed {
  ReportConfirmed(List<dynamic> response)
      : reviewer = (response[0] as _i1.EthereumAddress),
        reportId = (response[1] as BigInt);

  final _i1.EthereumAddress reviewer;

  final BigInt reportId;
}

class ReportRefused {
  ReportRefused(List<dynamic> response)
      : reviewer = (response[0] as _i1.EthereumAddress),
        reportId = (response[1] as BigInt);

  final _i1.EthereumAddress reviewer;

  final BigInt reportId;
}

class SwitchHigherPlan {
  SwitchHigherPlan(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        planNumber = (response[1] as BigInt),
        feeDifference = (response[2] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt planNumber;

  final BigInt feeDifference;
}

class SwitchLowerPlan {
  SwitchLowerPlan(List<dynamic> response)
      : address = (response[0] as _i1.EthereumAddress),
        utilityTokens = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt utilityTokens;
}

class Transfer {
  Transfer(List<dynamic> response)
      : from = (response[0] as _i1.EthereumAddress),
        to = (response[1] as _i1.EthereumAddress),
        value = (response[2] as BigInt);

  final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt value;
}
