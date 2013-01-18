
Getting started

    require 'inspectar'

Connect to a database

    Inspectar.attach adapter: 'mysql2', host: 'localhost', database: 'database', username: 'username', password: 'password'

Generate code defining activerecord models

    puts Inspectar.class_definitions

Define models to interact with your database quickly

    # given a table called invoices

    Inspectar.define_classes
    Inspectar::Invoice.all
