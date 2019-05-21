# CraveMe - Frontend

CraveMe is a dating web app that gives the users the opportunity to match with other users based on at least two craves out of four crave daily options they may have in common with other users. Then the user will get the option of choosing if the liked the other user and would like to start a conversation with them, it will also provides the idea of what to do for their first date... eat whatever they are craving and matched for.

Frontend for this project is located at https://github.com/link04/flatiron-final-project-crave-me-frontend

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

After cloning this project and going into the directory of the project run

```
$ bundle install

```
If you get a different version used form assign error, run then try the above step again
```
$ rvm use 2.5.3

```
Because this project uses PostgreSQL you need to turn on the server so it works properly.

```
$ rails db:create

$ rails db:migrate:up VERSION=20190424194912

$ rails db:migrate

```

Before you can seed the project you will have to create a seed a file inside the db folder and add this inside

```
Gender.create(name:'Male')
Gender.create(name:'Female')
Gender.create(name:'Transexual')
Gender.create(name:'Non-Binary')

```

Then using the API of your choice scrapped that and create different menu choices with at this 3 different categories

```
MenuChoice.create(name: 'Sirloin Steak', category: 'main_course')
MenuChoice.create(name: 'Apple Pie ', category: 'dessert')
MenuChoice.create(name: 'Coffee', category: 'drink')
```

After adding those lines with the corresponded data you should run

```
$ rails db:seed
```
Because this project uses ActionCable and I already setup redis, you need to run the below command on a different tab before turning on the server API itself
```
$ redis-server
```
Then you should run the below command, making sure you run it on a 3000 port if running it with the Frontend at the beginning of this repo
```
$ rails s
```
After doing this processes you should get a GCS bucket API key and copy that to the projects config folder then  update the storage file google credentials key name so you are able to upload pics to the cloud during production.


![](after-installation.gif)

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - Ruby server-side web application framework
* [Google Cloud Storage](https://cloud.google.com/storage/) - Unified object storage
* [PostgreSQL](https://www.postgresql.org/) - Database server

## Authors

* **Maximo Bautista** - *Initial work* - [link04](https://github.com/link04)
