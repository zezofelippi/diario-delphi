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

  Ela é dividida para ser utilizada tanto em desktop Windows como api em container Docker Linux para
  ser utilizada em nuvens

  A aplicação começou a ser desenvolvida utilizando:

  Delphi XE6 (VCL)

  Atualmente usando a versão:

  Delphi 10.4


Banco de Dados

  Firebird 2.5

  Arquivo com extensão .gdb

  Script de criação disponível em dataBase/dataBase_FireBird.sql

  A conexão é configurada na unit untDataModule através do componente
    FireDAC (FDConnection)

 Postgres para ser utilizada nas nuvens

Configuração da Conexão

   A conexão com o banco de dados é configurada dinamicamente através de um arquivo:
     config.ini

   O arquivo config.ini deve estar localizado na mesma pasta do executável (.exe)  ou na mesma pasta da api em caso de ser em nuvens.

   Há um exemplo na pasta do projeto:
     config.exampleFB.ini  config.examplePG.ini 


Organização Interna:

O projeto está dividido em três aplicações principais e um núcleo de código compartilhado, permitindo reutilização de regras de negócio entre o desktop VCL e a API REST em Linux (Docker).

desktop-vcl/     → Aplicação desktop desenvolvida em VCL (Firebird)
api-linux/       → API REST executando em Linux/Docker
frontend-html/   → Interface web simples em HTML + JavaScript
shared/          → Código compartilhado entre desktop e API
dataModule/      → Configuração de acesso a banco de dados por plataforma


Núcleo Compartilhado (shared/):

Contém as camadas de domínio e regras de negócio reutilizadas tanto pela aplicação desktop quanto pela API.

controller/        → Controladores responsáveis por orquestrar requisições entre camada externa e serviços

service/           → Implementação das regras de negócio

repository/        → Interfaces de acesso a dados (contratos)

repositoryFireDac/ → Implementações concretas de acesso a dados utilizando FireDAC

model/             → Entidades de domínio do sistema

classesGerais/     → Classes auxiliares reutilizáveis

funcoesGerais/     → Funções utilitárias de uso comum


Camada Desktop (desktop-vcl/):

Aplicação cliente desenvolvida com VCL.

FormsVCL/        → Telas da aplicação desktop

relatoriosHtml/  → Geração de relatórios em HTML

fbclient.dll -> caso use banco firebird colocar dll na mesma pasta do exe

midas.dll -> colocar na mesma pasta do exe


Camada API (api-linux/):

API REST executando em ambiente Linux dentro de container Docker.

Desenvolvida com Delphi usando WebBroker

Servidor HTTP baseado em Indy (IdHTTPWebBrokerBridge)

Utiliza PostgreSQL como banco de dados


Camada Frontend (frontend-html/):

Interface web simples utilizada para consumir a API.

index.html → Página principal

js/        → Scripts JavaScript para consumo da API REST



Tecnologias Utilizadas:

  Começou Delphi XE6 (VCL) e agora Delphi 10.4 

  Firebird 2.5  e Postgres

  FireDAC

  Arquitetura em Camadas (Controller / Service / Repository)

