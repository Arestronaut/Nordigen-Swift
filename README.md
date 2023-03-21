# Nordigen Swift

[![Swift](https://img.shields.io/badge/Swift-5.7-green?style=flat-round)](https://img.shields.io/badge/Swift-5.7-Green?style=flat-round)
[![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS-green?style=flat-round)](https://img.shields.io/badge/Platforms-macOS_iOS-Green?style=flat-round)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-round)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-round)

[Nordigen](https://nordigen.com/) is an open banking platform that provides free access to bank data. This library is a wrapper to access the Nordigen API written in Swift. 

**Important**: I'm in no way associated with Nordigen, this library is not officially supported by nordigen.

## Endpoints

The free version of the API is fully implemented in this wrapper. Following [this link](https://nordigen.com/en/docs/account-information/integration/parameters-and-responses/) there is a detailed list of all endpoints.

- [x] Accounts
    - [x] **GET** account
    - [x] **GET** {id}/balances
    - [x] **GET** {id}/details
    - [x] **GET** {id}/transactions

- [ ] Premium
    - [ ] **GET** {id}/transactions

- [x] Agreements
    - [x] **GET** enduser
    - [x] **POST** enduser
    - [x] **GET** enduser/{id}
    - [x] **DELETE** enduser/{id}
    - [x] **PUT** enduser/{id}/accept

- [x] Institution
    - [x] **GET** institutions
    - [x] **Get** institutions/{id}

- [x] Payments
    - [x] **GET** payments
    - [x] **POST** payments
    - [x] **GET** payments/{id}
    - [x] **DELETE** payments/{id}
    - [x] **POST** payments/{id}/submit
    - [x] **GET** account
    - [x] **GET** creditors
    - [x] **POST** creditors
    - [x] **GET** creditors/{id}
    - [x] **DELETE** creditors/{id}
    - [x] **GET** fields/{institution_id}

- [x] Requisitions
    - [x] **GET** requisitions
    - [x] **POST** requisitions
    - [x] **GET** requisitions/{id}
    - [x] **DELETE** requisitions/{id}

- [x] Token
    - [x] **POST** new
    - [x] **POST** refresh

## Documentation 

The official [Nordigen API documentation](https://nordigen.com/en/account_information_documenation/api-documention/overview/) is quite helpful for getting a grasp on how thr API is supposed to be used. Besides from that I created a [demo project](https://github.com/Arestronaut/Nordigen-Swift/tree/main/NordigenSwiftDemo) that will fill in the gaps of some implementation details. 

**Important notice**: In order to use the Nordigen service you need to create an account and generate user secrets. This can be done [here](https://ob.nordigen.com/user-secrets/)

## Contribution

### Reporting an issue
If you encounter any bugs or issues with the library, please open a new issue on our GitHub repository. Include a detailed description of the problem, steps to reproduce it, and any relevant error messages or logs.

### Pull requests
If you would like to contribute code changes, please follow these steps:

1. Fork the repository and create a new branch for your changes.
2. Make your changes and write tests to ensure they work as expected.
3. Run the test suite locally to ensure that all tests pass.
4. Submit a pull request to the main repository, including a detailed description of your changes and the problem they solve.

Please note that all contributions are subject to review and may be rejected if they do not align with the library's goals or coding standards.

## License 

NordigenSwift is released under MIT License. [See LICENSE](https://github.com/Arestronaut/Nordigen-Swift/blob/main/LICENSE) for details.

## Legal disclaimer

NordigenSwift is provided "as is" and without warranty of any kind, either express or implied, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose. In no event shall the author or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.

The user assumes all responsibility for the use of this software. The author and contributors will not be held liable for any damages that may occur from the use or misuse of this software.

Please be aware that this software may include third party libraries or components, which may be subject to separate license agreements. The author and contributors of this software make no
