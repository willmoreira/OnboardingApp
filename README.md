# 📱 OnboardingApp – Desafio Técnico iOS

Este projeto simula o início de um fluxo de verificação de identidade, com seleção de país, tipo de documento, data de nascimento e etapa mock de captura de imagem, inspirado em soluções comuns de fintechs.


## 🚀 Funcionalidades

| Tela                            | Funcionalidade                                                          |
|---------------------------------|-------------------------------------------------------------------------|
| Seleção de País                 | Lista mockada de países com bandeira e nome, permite seleção e avanço   |
| Seleção de Documento            | Lista de documentos válidos por país, com ícone e seleção               |
| Inserção de Data de Nascimento  | Inserção da data de nascimento com validação de idade minima e avanço   |
| Captura de Documento            | Simulação de captura com imagem mock e opção de recaptura e envio       |


## 🧱 Arquitetura
VIPER (View, Interactor, Presenter, Entity, Router)
Estrutura modular e testável, com responsabilidades bem definidas:

View: exibe a interface e responde às ações do usuário

Interactor: lógica de negócio e regras da aplicação

Presenter: formata dados para exibição e comunica a lógica com a view

Entity: modelos usados pelas regras de negócio

Router: responsável pela navegação entre as telas

Coordinator para controle centralizado do fluxo de navegação

Protocolos e injeção de dependência para desacoplamento e testabilidade


## 📂 Organização do Projeto

<img width="543" height="646" alt="img3" src="https://github.com/user-attachments/assets/dc247041-ca2b-4b92-8890-1b0da30473e2" />

## 📲 Requisitos

- **Xcode**: 16.4 (16F6)
- **iOS mínimo**: 18.0
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

✅ Seleção de país com lista mockada

✅ Seleção de documento com base no país

✅ Tela de captura mockada com imagem simulada

✅ Armazenamento local com UserDefaults

✅ Arquitetura VIPER com navegação via Coordinator

✅ Validação básica de dados

✅ Testes unitários cobrindo Interactor e Presenter

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

<img width="1302" height="665" alt="Captura de Tela 2025-07-27 às 23 48 23" src="https://github.com/user-attachments/assets/253440a3-e558-41b7-b2b4-d1ae97b5278b" />
<img width="1300" height="758" alt="Captura de Tela 2025-07-27 às 23 48 45" src="https://github.com/user-attachments/assets/a439d694-d0d0-4df4-938b-9375dd6c623a" />

✅ UI Tests
Testes automatizados para todas as telas

Rodar testes:
⌘ + U (ou via Product > Test)

## ❌ Itens não entregues
❌ Modularização com Tuist/SPM
⤷ Optei por priorizar clareza arquitetural e foco nas entregas core.

❌ SwiftUI
⤷ A inclusão demandaria esforço na arquitetura (VIPER + UIKit) e falta de dominio na navegação para a implementação da tecnologia

## 📸 Screenshots

<img width="200" height="433" alt="IMG_6581" src="https://github.com/user-attachments/assets/b82198b2-7008-484e-a0ee-5b8fade12af5" />
<img width="200" height="433" alt="IMG_6582" src="https://github.com/user-attachments/assets/fb3b90f2-c851-44b0-a3fe-e5d4ce254b9b" />
<img width="200" height="433" alt="IMG_6582" src="https://github.com/user-attachments/assets/3953c32b-7d7e-4fb8-b22e-061e6d2ff3a2" />
<img width="200" height="433" alt="IMG_6583" src="https://github.com/user-attachments/assets/a079de86-c6a9-40b0-8017-d84694ab00af" />

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
