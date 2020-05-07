# README

## Ruby Version
#### 2.6.5

## Rails Version
#### 6.0.2

## Gems utilizadas
- [**Mutation**](https://github.com/cypriss/mutations): Usa o Command Pattern, ara extrair a lógica dos controllers
- [**JWT**](https://github.com/jwt/ruby-jwt): Codificação e validação de JSON Web Tokens
- [**Rspec**](https://rspec.info/): Framework para escrever testes automatizados
- [**Factory Bot**](https://github.com/thoughtbot/factory_bot): Auxilia na criação de objetos para teste
- [**Pry**](https://github.com/rweng/pry-rails) - Adiciona breakpoints no código para ajudar a debugar
- [**Shoulda Matchers**](https://github.com/thoughtbot/shoulda-matchers): Em conjunto com o Rspec auxilia na escrita de testes para funcionalidades mais comuns no rails
- [**Database Cleaner**](https://github.com/DatabaseCleaner/database_cleaner):  Limpa o banco de dados de teste a cada novo teste executado, evita o conflito de dados durante a
  execução dos testes
- [**Rubocop**](https://github.com/rubocop-hq/rubocop): Força a utilização do rails style guide para ajudar na qualidade do código escrito
- [**Guard Rspec**](https://github.com/guard/guard-rspec): Detecta mudanças e executa os testes automaticamente

## Rodando o projeto com Docker
### Dependencies
  - [Docker](https://docker.com/)
  - [Docker Compose](https://docs.docker.com/compose/)

## Build containers

```
sudo docker-compose build
```
### Cria o banco de dados e roda as migration
```bash
sudo docker-compose run --rm web rails db:create db:migrate
```
### Subindo os containers
```bash
sudo docker-compose up
```
O servidor estará disponível em: [http://localhost:3000](http://localhost:3000)

## Rodando os testes

```bash
docker-compose run web bundle exec rspec --format=doc
```

## Interagindo com a API
É possível interagir com a api usando cURL [cURL](https://curl.haxx.se/) ou outra ferramenta como [Postman](https://www.postman.com/).

Usando cURL:

### Criando uma nova conta
```bash
curl -X POST "http://localhost:3000/api/v1/accounts" -H "Content-Type: application/json" \
-d '{
    "account": {
        "name": "Minha nova conta",
        "balance": 1900.00
    }
}'
```

### Consultando saldo
```bash
curl -X GET "http://localhost:3000/api/v1/accounts/1" -H "Content-Type: application/json" \
-H "Authorization: Bearer <authorization_token>"
```

### Transferência entre contas
```bash
curl -X POST "http://localhost:3000/api/v1/transactions" -H "Content-Type: application/json" \
-H "Authorization: Bearer <authorization_token>" \
-d '{
    "transaction": {
        "source_account_id": <source_account_id>,
        "destination_account_id": <destination_account_id>,
        "amount": 25.83
    }
}'
```
