# 📱 OnboardingApp – Desafio Técnico iOS Sênior

Este projeto simula o início de um fluxo de verificação de identidade, com seleção de país, tipo de documento e uma etapa mock de captura de imagem, inspirado em soluções comuns de fintechs.


## 🚀 Funcionalidades

| Tela                      | Funcionalidade                                                                |
|---------------------------|-------------------------------------------------------------------------------|
| Seleção de País           | Lista mockada de países com bandeira e nome, permite seleção e avanço         |
| Seleção de Documento      | Lista de documentos válidos por país, com ícone e seleção                     |
| Captura de Documento      | Simulação de captura com imagem mock e opção de recaptura e envio             |


## 🧱 Arquitetura

- **VIP (View + Interactor + Presenter)**
- **Coordinator** para controle de navegação
- Separação clara entre camadas, com uso de protocolos e injeção de dependência


## 📂 Organização do Projeto

<img width="276" height="640" alt="img" src="https://github.com/user-attachments/assets/2f9b1547-d907-47a1-8394-46080c214f25" />




## 📲 Requisitos

- **Xcode**: 16.4 (16F6)
- **iOS mínimo**: 15.0
- **Dependências**: Nenhuma externa
- **Dispositivo físico ou simulador**: ambos funcionam


## 🛠️ Como rodar o projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/OnboardingApp.git

2. Abra o projeto no Xcode:
open OnboardingApp.xcodeproj

3. Selecione um simulador (ou dispositivo real) e clique em Run ▶️


## ✅ MVP Entregue

- Seleção de país com lista mock
- Seleção de documento com base no país
- Tela de captura mockada com imagem simulada
- Armazenamento local usando UserDefaults
- Arquitetura VIP com Coordinator
- Testes unitários: Interactor + Presenter

## ✨ Diferenciais implementados (Plus)

✅ Navegação com Coordinator Pattern

✅ Testes de UI com XCTest

✅ Acessibilidade nas três telas (VoiceOver)

✅ Logger de eventos mockado (analytics)

✅ SwiftLint configurado

✅ README técnico com instruções

## 🧪 Testes
✅ Unitários
Testes para Presenter e Interactor de todas as telas

✅ UI Tests
Testes automatizados para fluxo completo do usuário

Rodar testes:
⌘ + U (ou via Product > Test)

## ❌ Itens não entregues
❌ Modularização com Tuist/SPM
⤷ Optei por priorizar clareza arquitetural e qualidade das entregas core.

❌ SwiftUI
⤷ Como o projeto foi estruturado com UIKit + VIP, a inclusão exigiria mudanças amplas de arquitetura em tempo limitado.

## 📸 Screenshots

<img width="292" height="633" alt="IMG_6581" src="https://github.com/user-attachments/assets/b82198b2-7008-484e-a0ee-5b8fade12af5" />
<img width="292" height="633" alt="IMG_6582" src="https://github.com/user-attachments/assets/fb3b90f2-c851-44b0-a3fe-e5d4ce254b9b" />
<img width="292" height="633" alt="IMG_6583" src="https://github.com/user-attachments/assets/a079de86-c6a9-40b0-8017-d84694ab00af" />

## 📈 Analytics

Eventos logados em cada etapa:

País selecionado

Documento selecionado

Captura de documento simulada

Os eventos são enviados por uma classe mock que simula um sistema de log analitics.

## 🧼 SwiftLint
SwiftLint está ativo e configurado no projeto para garantir boas práticas e padronização.

## 👨‍💻 Autor
William Moreira
https://github.com/willmoreira
