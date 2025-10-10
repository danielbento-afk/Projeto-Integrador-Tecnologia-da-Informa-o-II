# Hora Certa - Cronograma de Estudos

## 📄 Descrição do Projeto

O **Hora Certa** é uma aplicação web front-end desenvolvida para ajudar estudantes a organizar sua rotina de estudos de forma eficiente e visual. A plataforma permite que os usuários cadastrem seus cursos e disciplinas, definam sua disponibilidade semanal e, com base nessas informações, gerem um cronograma de estudos inteligente, exibido em um calendário mensal interativo.

## Como fazer Login
```
email: user@example.com
senha: password
```

### ✨ Funcionalidades Principais

* **Autenticação de Usuário:** Telas de Login e Cadastro com validação de dados (simuladas no front-end).
* **Gerenciamento de Cursos:** Adição, edição e remoção de cursos e disciplinas, com definição de carga horária.
* **Definição de Disponibilidade:** Interface simplificada para o usuário informar seus dias e horas de estudo disponíveis por semana.
* **Análise de Capacidade:** Cálculo automático que compara as horas de estudo disponíveis com a demanda total das matérias.
* **Cronograma Inteligente:** Geração de um plano de estudos visual em um calendário mensal, com navegação entre os meses.
* **Dashboard Central:** Painel de controle com acesso rápido às principais funcionalidades e resumos.
* **Design Responsivo:** Interface adaptável para uma boa experiência em desktops e dispositivos móveis.

---

## 💻 Tecnologias Utilizadas

A aplicação foi construída utilizando o ecossistema moderno do JavaScript, com foco no Vue.js.

* **Framework Principal:** [Vue.js](https://vuejs.org/) (Versão 3, com Composition API)
* **Roteamento:** [Vue Router](https://router.vuejs.org/)
* **Linguagem:** JavaScript (ES6+)
* **Estrutura e Estilização:** HTML5 e CSS3
* **Gráficos (Tela de Relatórios):** [Chart.js](https://www.chartjs.org/) com [Vue-ChartJS](https://vue-chartjs.org/)
* **Ambiente de Execução:** [Node.js](https://nodejs.org/)
* **Gerenciador de Pacotes:** [npm](https://www.npmjs.com/)
* **Ferramenta de Build:** [Vue CLI](https://cli.vuejs.org/)

---

## 🔧 Instruções de Instalação e Uso

Siga os passos abaixo para executar o projeto em seu ambiente local.

### Pré-requisitos

Antes de começar, certifique-se de que você tem o [Node.js](https://nodejs.org/) (que inclui o npm) instalado em sua máquina.

### Passos para Instalação

1.  **Clone o repositório** (ou simplesmente descompacte os arquivos do projeto em uma pasta):
    ```bash
    git clone [https://github.com/seu-usuario/seu-repositorio.git](https://github.com/seu-usuario/seu-repositorio.git)
    ```

2.  **Navegue até a pasta do projeto:**
    ```bash
    cd cronograma-de-estudos
    ```

3.  **Instale todas as dependências** listadas no `package.json`:
    ```bash
    npm install
    ```

### Executando a Aplicação

1.  **Inicie o servidor de desenvolvimento local:**
    ```bash
    npm run serve
    ```
    A aplicação estará disponível em `http://localhost:8080`. O servidor recarregará automaticamente a página sempre que você fizer uma alteração nos arquivos.

2.  **Acessando a aplicação:**
    * Abra seu navegador e acesse `http://localhost:8080`.
    * Para testar a aplicação, use as credenciais de login simuladas:
        * **Email:** `user@example.com`
        * **Senha:** `password`

### Outros Comandos Úteis

* **Compilar para produção:**
    ```bash
    npm run build
    ```
    Este comando cria uma versão otimizada da aplicação na pasta `dist`, pronta para ser hospedada em um servidor web.

* **Verificar e corrigir erros de lint:**
    ```bash
    npm run lint
    ```

---

## 📁 Estrutura de Diretórios

A estrutura de pastas do projeto segue as convenções do Vue CLI, com foco na organização e escalabilidade.

```
cronograma-de-estudos/
├── public/
│   └── index.html      # O template HTML principal da aplicação
├── src/
│   ├── assets/
│   │   └── main.css      # Arquivo de estilos globais
│   ├── components/
│   │   └── AppHeader.vue   # Componentes reutilizáveis (ex: cabeçalho)
│   ├── router/
│   │   └── index.js      # Configuração de todas as rotas da aplicação
│   ├── views/
│   │   ├── LoginView.vue   # Componentes que representam páginas inteiras
│   │   └── ...
│   ├── App.vue           # O componente raiz da aplicação
│   └── main.js           # O ponto de entrada da aplicação
├── .gitignore
├── package.json          # Lista de dependências e scripts do projeto
└── README.md             # Este arquivo
```
* **`public/`**: Contém o arquivo `index.html` base e outros assets que não são processados pelo Webpack.
* **`src/`**: O coração da aplicação, onde todo o código-fonte reside.
* **`src/assets/`**: Armazena arquivos estáticos como folhas de estilo globais e imagens.
* **`src/components/`**: Contém componentes Vue reutilizáveis que são usados em várias `views` (ex: `AppHeader.vue`).
* **`src/router/`**: Define o mapeamento entre as URLs e os componentes `view` que devem ser renderizados.
* **`src/views/`**: Contém os componentes Vue que representam as páginas completas da aplicação (ex: tela de Login, Dashboard, etc.).
* **`src/main.js`**: O arquivo principal que inicializa a instância do Vue, o roteador e monta a aplicação no `index.html`.
* **`src/App.vue`**: O componente raiz que serve como layout principal, contendo o cabeçalho e o `<router-view>` onde as páginas são renderizadas.
  
## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
