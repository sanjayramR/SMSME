import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BlockChain {
  Client httpClient;
  Web3Client ethClient;
  DeployedContract contract;
  ContractFunction _setPatientDetails;
  ContractFunction _setMedicine;
  ContractFunction _setRecord;
  ContractFunction _getPatientDetails;
  ContractFunction _getMedicines;
  ContractFunction _getRecords;
  Credentials credentials;
  EthereumAddress contractAddress;

  BlockChain() {
//    initialSetup();
  }

  setPatientDetails(
      String patientId, String name, String age, String gender) async {
    print("Calling SetPatientDetails function!!!");
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _setPatientDetails = contract.function("setPatientDetails");
    var result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: _setPatientDetails,
            parameters: [patientId, name, age, gender]),
        fetchChainIdFromNetworkId: true);
    print(result);
    print("Patient Details Updated Successfully!!!");
  }
//setMedicine(String patientId, String medicineName, String dosage) async {
  setMedicine(String medicineName, String dosage, String patientId) async {
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _setMedicine = contract.function("addMedicine");
    await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: _setMedicine,
            parameters: [patientId, medicineName, dosage]),
            fetchChainIdFromNetworkId: true);
    print("Medicine Details Updated Successfully!!!");
  }
//setRecord(String patientId, String description, String date) async {
  setRecord(String description, String date, String patientId) async {
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _setRecord = contract.function("addRecord");
    await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: _setRecord,
            parameters: [patientId, description, date]),
            fetchChainIdFromNetworkId: true);
    print("Patient Record Details Updated Successfully!!!");
  }

  Future<List> getPatientDetails(String patientId) async {
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _getPatientDetails = contract.function("getPatientDetails");
    ContractFunction pc = contract.function("patientCount");
    print(contract);
    print("Get Patient Details was called!!!");
    var result = await ethClient.call(
        contract: contract, function: _getPatientDetails, params: [patientId]);
    print("Patient Details RESULT ARRIVED!!!!!");
    print(result);
    return result;
  }

  getMedicines(String patientId) async {
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _getMedicines = contract.function("getMedicines");
    var result = await ethClient
        .call(contract: contract, function: _getMedicines, params: [patientId]);
    print("Medical Details RESULT ARRIVED!!!!!");
    print(result);
  }

  getRecords(String patientId) async {
    httpClient = Client();
    ethClient = Web3Client(DotEnv().env['API'], httpClient);
    String abi = await rootBundle.loadString("assets/abi.json");
    contractAddress = EthereumAddress.fromHex(DotEnv().env['CONTRACT_ADDRESS']);
    credentials =
        await ethClient.credentialsFromPrivateKey(DotEnv().env['CREDENTIAL']);
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "User"), contractAddress);
    _getRecords = contract.function("getRecords");
    var result = await ethClient
        .call(contract: contract, function: _getRecords, params: [patientId]);
    print("Patient Record Details RESULT ARRIVED!!!!!");
    print(result);
  }
}
