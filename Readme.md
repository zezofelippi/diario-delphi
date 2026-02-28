Sobre o Projeto

  O Diário é um sistema para registro diário de atividades, permitindo cadastrar:

  Tipo de atividade

  Atividade

  Movimentação de horas (quantidade de horas realizadas por dia)
  
  O sistema também possui:

    Campo Acordar — registro do horário em que o usuário se levantou

    Campo Observação — descrição detalhada das tarefas executadas

  Com o uso contínuo, o sistema se torna um histórico completo das atividades realizadas, podendo servir como um verdadeiro diário de   produtividade e até histórico de vida.


Arquitetura

  O projeto é baseado em arquitetura em camadas, organizada em:

  Controller

  Service

  Repository (baseado em interface)

  RepositoryFireDac (implementação concreta)

  A aplicação foi desenvolvida utilizando:

  Delphi XE6 (VCL)


Banco de Dados

  Firebird 2.5

  Arquivo com extensão .gdb

  Script de criação disponível em dataBase/dataBase_FireBird.sql

  A conexão é configurada na unit untDataModule através do componente
    FireDAC (FDConnection)

Estrutura das Pastas:

Diario/
│
├── Diario.dpr
├── README.md
├── .gitignore
│
├── banco_de_dados/
│   └── BASE_DADOS_HORAS.GDB
│
├── dataBase/
│   └── dataBase_FireBird.sql
│
└── src/
    ├── classesGerais/
    ├── funcoesGerais/
    │
    ├── controller/
    │   └── controleHoras/
    │
    ├── service/
    │   └── controleHoras/
    │
    ├── repository/
    │   └── controleHoras/
    │
    ├── repositoryFireDac/
    │   └── controleHoras/
    │
    ├── model/
    │   └── controleHoras/
    │
    ├── dataModule/
    │
    └── view/
        ├── FormsVCL/
        │   └── controleHoras/
        └── relatoriosHtml/
            └── controleHoras/

Organização Interna (src/)

  O código-fonte está organizado conforme separação de responsabilidades:

  controller/ → Orquestra as requisições entre View e Service

  service/ → Regras de negócio

  repository/ → Interfaces de acesso a dados

  repositoryFireDac/ → Implementações concretas utilizando FireDAC
 
  model/ → Entidades do domínio

  view/ → Forms VCL e geração de relatórios HTML

  dataModule/ → Configuração de conexão com banco

  classesGerais/ → Classes auxiliares reutilizáveis

  funcoesGerais/ → Funções utilitárias


Tecnologias Utilizadas:

  Delphi XE6 (VCL)

  Firebird 2.5

  FireDAC

  Arquitetura em Camadas (Controller / Service / Repository)

