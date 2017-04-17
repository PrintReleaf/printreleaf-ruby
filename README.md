# PrintReleaf Ruby API &nbsp; [![Build Status](https://travis-ci.org/PrintReleaf/printreleaf-ruby.svg)](https://travis-ci.org/PrintReleaf/printreleaf-ruby) [![Code Climate](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby/badges/gpa.svg)](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby) [![Test Coverage](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby/badges/coverage.svg)](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby/coverage) [![Issue Count](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby/badges/issue_count.svg)](https://codeclimate.com/github/PrintReleaf/printreleaf-ruby)

Ruby toolkit for the [PrintReleaf API](https://printreleaf.com/docs/api).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'printreleaf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install printreleaf


## API and Object Reference

Complete API spec and object reference can be found here: [printreleaf.com/docs/api](https://printreleaf.com/docs/api).


## Configuration

```ruby
PrintReleaf.api_key  = "<your PrintReleaf API key>"
```

`config/initializers/printreleaf.rb` is a good place for this if you are using Rails.


# Usage

## Accounts

### My Account

```ruby
account = PrintReleaf::Account.mine #=> #<PrintReleaf::Account>
account.id                          #=> "a2c031fa-6599-4939-8bc6-8128881953c4"
account.name                        #=> "My Account"
account.role                        #=> "customer"
account.created_at                  #=> "2014-03-06T23:06:23+00:00"
account.parent_id                   #=> nil
account.status                      #=> "active"
account.activated_at                #=> "2014-03-06T23:06:23+00:00"
account.deactivated_at              #=> nil
account.accounts_count              #=> 2
account.users_count                 #=> 2
account.mtd_pages                   #=> 1234
account.qtd_pages                   #=> 12345
account.ytd_pages                   #=> 123456
account.lifetime_pages              #=> 1234567
account.mtd_trees                   #=> 0.15
account.qtd_trees                   #=> 1.48
account.ytd_trees                   #=> 14.82
account.lifetime_trees              #=> 148.1
```

### Listing Accounts

```ruby
PrintReleaf::Account.list #=> [#<PrintReleaf::Account>, #<PrintReleaf::Account>]
```

### Retrieving an Account

```ruby
PrintReleaf::Account.find("a2c031fa-6599-4939-8bc6-8128881953c4") #=> #<PrintReleaf::Account>
```

### Creating an Account

```ruby
account = PrintReleaf::Account.create(name: "Account A") #=> #<PrintReleaf::Account>
```

### Updating an Account

```ruby
account.name = "Account B"
account.save #=> true
```

### Activating an Account

```ruby
account.activate #=> true
```

### Deactivating an Account

```ruby
account.deactivate #=> true
```

## Certificates

### Listing Certificates

```ruby
PrintReleaf::Certificate.list #=> [#<PrintReleaf::Certificate>, #<PrintReleaf::Certificate>]
# -or-
account.certificates #=> [#<PrintReleaf::Certificate>, #<PrintReleaf::Certificate>]
```

### Retrieving a Certificate

```ruby
certificate = PrintReleaf::Certificate.find("ae630937-e15b-4da5-98de-bb68eefe2a12") #=> #<PrintReleaf::Certificate>
# -or-
certificate = account.certificates.find("ae630937-e15b-4da5-98de-bb68eefe2a12") #=> #<PrintReleaf::Certificate>

certificate.id         #=> "ae630937-e15b-4da5-98de-bb68eefe2a12"
certificate.account_id #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
certificate.account    #=> #<PrintReleaf::Account>
certificate.date       #=> "2017-02-28T23:59:59Z"
certificate.pages      #=> 2469134
certificate.trees      #=> 296.31
certificate.project_id #=> "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9"
certificate.project    #=> #<PrintReleaf::Forestry::Project>
certificate.url        #=> "https://printreleaf.com/certificates/ae630937-e15b-4da5-98de-bb68eefe2a12",
certificate.pdf_url    #=> "https://printreleaf.com/certificates/ae630937-e15b-4da5-98de-bb68eefe2a12.pdf"
```


## Deposits

### Listing Deposits

```ruby
PrintReleaf::Deposit.list #=> [#<PrintReleaf::Deposit>, #<PrintReleaf::Deposit>]
# -or-
account.deposits #=> [#<PrintReleaf::Deposit>, #<PrintReleaf::Deposit>]
```

### Retrieving a Deposit

```ruby
deposit = PrintReleaf::Deposit.find("a86d591c-3c29-4bef-82c3-7a007fb6b19c") #=> #<PrintReleaf::Deposit>
# -or-
deposit = account.deposits.find("a86d591c-3c29-4bef-82c3-7a007fb6b19c") #=> #<PrintReleaf::Deposit>

deposit.id            #=> "a86d591c-3c29-4bef-82c3-7a007fb6b19c"
deposit.account_id    #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
deposit.account       #=> #<PrintReleaf::Account>
deposit.source_id     #=> "44e182ed-cd50-4fa1-af90-e77dd6d6a78c"
deposit.source        #=> #<PrintReleaf::Source>
deposit.date          #=> "2016-07-05T12:29:12Z"
deposit.pages         #=> 20000
deposit.width         #=> 0.2127
deposit.height        #=> 0.2762
deposit.density       #=> 216.0
deposit.paper_type_id #=> "a11c7abc-011e-462f-babb-3c6375fa6473
deposit.paper_type    #=> #<PrintReleaf::Paper::Type>
```

### Creating a Deposit

```ruby
deposit = PrintReleaf::Deposit.create(pages: 16_666) #=> #<PrintReleaf::Deposit>
```

### Deleting a Deposit

```ruby
deposit.delete #=> true
```


## Invitations

### Listing Invitations

```ruby
PrintReleaf::Invitation.list #=> [#<PrintReleaf::Invitation>, #<PrintReleaf::Invitation>]
# -or-
account.invitations #=> [#<PrintReleaf::Invitation>, #<PrintReleaf::Invitation>]
```

### Retrieving an Invitation

```ruby
invitation = PrintReleaf::Invitation.find("26370b1e-15a5-4449-b3b1-622e99003d3f") #=> #<PrintReleaf::Invitation>
# -or-
invitation = account.invitations.find("26370b1e-15a5-4449-b3b1-622e99003d3f") #=> #<PrintReleaf::Invitation>

invitation.id         #=> "26370b1e-15a5-4449-b3b1-622e99003d3f"
invitation.account_id #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
invitation.account    #=> #<PrintReleaf::Account>
invitation.email      #=> "sally@example.com"
invitation.created_at #=> "2016-03-07T00:04:09Z
```

### Creating an Invitation

```ruby
invitation = PrintReleaf::Invitation.create(email: "person@example.com") #=> #<PrintReleaf::Invitation>
```

### Deleting an Invitation

```ruby
invitation.delete #=> true
```


## Servers

### Listing Servers

```ruby
PrintReleaf::Server.list #=> [#<PrintReleaf::Server>, #<PrintReleaf::Server>]
# -or-
account.servers #=> [#<PrintReleaf::Server>, #<PrintReleaf::Server>]
```

### Retrieving a Server

```ruby
server = PrintReleaf::Server.find("eadabb78-b199-43cb-adbd-ab36ce5c5a10") #=> #<PrintReleaf::Server>
# -or-
server = account.servers.find("eadabb78-b199-43cb-adbd-ab36ce5c5a10") #=> #<PrintReleaf::Server>

server.id         #=> "eadabb78-b199-43cb-adbd-ab36ce5c5a10"
server.account_id #=> "a2c031fa-6599-4939-8bc6-8128881953c4"
server.account    #=> #<PrintReleaf::Account>
server.type       #=> "fmaudit"
server.url        #=> "https://myfmauditserver.com"
server.username   #=> "MyFMAuditUsername"
server.created_at #=> "2015-03-07T00:04:09Z"
```

### Creating a Server

```ruby
server = PrintReleaf::Server.create(
  type:     "printfleet",
  url:      "https://myprintfleetserver.com",
  username: "MyPrintFleetUsername",
  password: "MyPrintFleetPassword"
) #=> #<PrintReleaf::Server>
```

### Updating a Server

```ruby
server.url = "https://example.com"
server.save #=> true
```

### Deleting a Server

```ruby
server.delete #=> true
```


## Sources

### Listing Sources

```ruby
PrintReleaf::Source.list #=> [#<PrintReleaf::Source>, #<PrintReleaf::Source>]
# -or-
account.sources #=> [#<PrintReleaf::Source>, #<PrintReleaf::Source>]
```

### Retrieving a Source

```ruby
source = PrintReleaf::Source.find("44e182ed-cd50-4fa1-af90-e77dd6d6a78c") #=> #<PrintReleaf::Source>
# -or-
source = account.sources.find("44e182ed-cd50-4fa1-af90-e77dd6d6a78c") #=> #<PrintReleaf::Source>

source.id                      #=> "44e182ed-cd50-4fa1-af90-e77dd6d6a78c"
source.account_id              #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
source.account                 #=> #<PrintReleaf::Account>
source.type                    #=> "fmaudit"
source.server_id               #=> "eadabb78-b199-43cb-adbd-ab36ce5c5a10"
source.server                  #=> #<PrintReleaf::Server>
source.external_id             #=> "456"
source.collection_scope        #=> "managed_only"
source.created_at              #=> "2016-03-07T00:04:09Z"
source.status                  #=> "active"
source.activated_at            #=> "2016-03-07T00:04:09Z"
source.deactivated_at          #=> nil
source.health_check            #=> "healthy"
source.health_check_checked_at #=> "2017-03-07T00:04:09Z"
source.health_check_changed_at #=> "2017-03-07T00:04:09Z"
```

### Creating a Source

```ruby
source = PrintReleaf::Source.create(
  type: "printfleet",
  server_id: "9a6a1ced-4e71-4919-9d6d-25075834c404",
  external_id: "732ec0d3-20e3-439e-94e6-e64b40eb533a"
) #=> #<PrintReleaf::Source>
```

### Updating a Source

```ruby
source.external_id = "abc123"
source.save #=> true
```

### Activating a Source

```ruby
source.activate #=> true
```

### Deactivating a Source

```ruby
source.deactivate #=> true
```

### Deleting a Source

```ruby
source.delete #=> true
```


## Transactions

### Listing Transactions

```ruby
PrintReleaf::Transaction.list #=> [#<PrintReleaf::Transaction>, #<PrintReleaf::Transaction>]
# -or-
account.transactions #=> [#<PrintReleaf::Transaction>, #<PrintReleaf::Transaction>]
```

### Retrieving a Transaction

```ruby
transaction = PrintReleaf::Transaction.find("70af5540-e3ec-4db7-bc45-4fb65b74368b") #=> #<PrintReleaf::Transaction>
# -or-
transaction = account.transactions.find("70af5540-e3ec-4db7-bc45-4fb65b74368b") #=> #<PrintReleaf::Transaction>

transaction.id             #=> "70af5540-e3ec-4db7-bc45-4fb65b74368b"
transaction.account_id     #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
transaction.account        #=> #<PrintReleaf::Account>
transaction.project_id     #=> "692bb68d-64aa-4a79-8a08-d373fb0d8752"
transaction.account        #=> #<PrintReleaf::Forestry::Project>
transaction.certificate_id #=> "70af5540-e3ec-4db7-bc45-4fb65b74368b"
transaction.account        #=> #<PrintReleaf::Certificate>
transaction.date           #=> "2015-10-22T01:52:12Z"
transaction.trees          #=> 63.048
transaction.items          #=> [#<PrintReleaf::TransactionItem>, #<PrintReleaf::TransactionItem>]
```

### Creating a Transaction

```ruby
# Providing only trees:
transaction = PrintReleaf::Transaction.create(trees: 2.0) #=> #<PrintReleaf::Transaction>

# or providing raw paper specs:
transaction = PrintReleaf::Transaction.create(
  items: [
    {
      pages: 20000,
      width: 0.2127,
      height: 0.2762,
      paper_type_id: "a11c7abc-011e-462f-babb-3c6375fa6473"
    },
    {
      pages: 400000,
      width: 0.2127,
      height: 0.2762,
      paper_type_id: "bbd0f271-2f9e-494c-b2af-7f9354b310ad"
    }
  ]
) #=> #<PrintReleaf::Transaction>
```

### Deleting a Transaction

```ruby
transaction.delete #=> true
```


## Users

### Listing Users

```ruby
PrintReleaf::User.list #=> [#<PrintReleaf::User>, #<PrintReleaf::User>]
# -or-
account.users #=> [#<PrintReleaf::User>, #<PrintReleaf::User>]
```

### Retrieving a User

```ruby
user = PrintReleaf::User.find("5f25569f-ec0d-4ff3-a6ce-0456ac79b84d") #=> #<PrintReleaf::User>
# -or-
user = account.users.find("5f25569f-ec0d-4ff3-a6ce-0456ac79b84d") #=> #<PrintReleaf::User>

user.id         #=> "5f25569f-ec0d-4ff3-a6ce-0456ac79b84d"
user.account_id #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
user.account    #=> #<PrintReleaf::Account>
user.name       #=> "Sally Example"
user.email      #=> "sally@example.com"
user.created_at #=> "2015-03-07T00:04:09Z
```

### Deleting a User

```ruby
user.delete #=> true
```


## Volume

### Listing volume history

```ruby
PrintReleaf::VolumePeriod.list #=> [#<PrintReleaf::VolumePeriod>, #<PrintReleaf::VolumePeriod>]
# -or-
account.volume #=> [#<PrintReleaf::VolumePeriod>, #<PrintReleaf::VolumePeriod>]

volume_period = account.volume.first
volume_period.account_id #=> "971d10ac-a912-42c0-aa41-f55adc7b6755"
volume_period.account    #=> #<PrintReleaf::VolumePeriod>
volume_period.date       #=> "2017-01-01T07:00:00Z"
volume_period.pages      #=> 234567
volume_period.trees      #=> 56.3
```

#### With parameters

```ruby
PrintReleaf::VolumePeriod.list(
  start_date: "2017-03-01",
  end_date:   "2017-03-03",
  period:     "daily"
) #=> [#<PrintReleaf::VolumePeriod>, #<PrintReleaf::VolumePeriod>, #<PrintReleaf::VolumePeriod>]
```


## Forestry Projects

### Listing Projects

```ruby
PrintReleaf::Forestry::Project.list #=> [#<PrintReleaf::Forestry::Project>, #<PrintReleaf::Forestry::Project>]
```

### Retrieving a Project

```ruby
project = PrintReleaf::Forestry::Project.find("5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9") #=> #<PrintReleaf::Forestry::Project>
project.id                   #=> "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9"
project.name                 #=> "Madagascar"
project.status               #=> "active"
project.forest_latitude      #=> -15.735844444444444
project.forest_longitude     #=> 46.35879166666667
project.content_logo         #=> "http://s3.amazonaws.com/projects/madagascar/logo.jpg"
project.content_masthead     #=> "http://s3.amazonaws.com/projects/madagascar/masthead.jpg"
project.content_introduction #=> "Madagascar, due to its isolation from the rest of the world..."
project.content_body_html    #=> "<h1>Madagascar is one of the most threatened ecosystems on the planet..."
project.content_images       #=> ["http://s3.amazonaws.com/projects/madagascar/1.jpg", ...]
```


## Paper Types

### Listing Paper Types

```ruby
PrintReleaf::Paper::Type.list #=> [#<PrintReleaf::Paper::Type>, #<PrintReleaf::Paper::Type>]
```

### Retrieving a Paper Type

```ruby
paper_type = PrintReleaf::Paper::Type.find("a11c7abc-011e-462f-babb-3c6375fa6473") #=> #<PrintReleaf::Paper::Type>
paper_type.id         #=> "a11c7abc-011e-462f-babb-3c6375fa6473"
paper_type.account_id #=> "a2c031fa-6599-4939-8bc6-8128881953c4"
paper_type.account    #=> #<PrintReleaf::Account>
paper_type.name       #=> "80# #2 Gloss Cover"
paper_type.density    #=> 216.0
```

### Creating a Custom Paper Type

```ruby
paper_type = PrintReleaf::Paper::Type.create(
  name:    "20# Bond/Writing/Ledger",
  density: 74.0
) #=> #<PrintReleaf::Paper::Type>
```

### Deleting a Paper Type

```ruby
paper_type.delete #=> true
```

## Exceptions

PrintReleaf will raise exceptions for most failure scenarios, including invalid parameters, authentication errors, and network errors. Most exceptions will inherit from `PrintReleaf::Error`, making it easy to gracefully handle all possible API exceptions.

```ruby
begin
  # Use PrintReleaf to make requests...
rescue PrintReleaf::RateLimitExceeded => e
  # Too many requests made to the API too quickly
rescue PrintReleaf::BadRequest => e
  # Invalid parameters were supplied to PrintReleaf's API
rescue PrintReleaf::Unauthorized => e
  # Missing or invalid API key
rescue PrintReleaf::Forbidden => e
  # The requested action is not permitted
rescue PrintReleaf::NetworkError => e
  # Network communication with PrintReleaf failed
rescue PrintReleaf::Error => e
  # Catch all generic PrintReleaf errors
rescue => e
  # Something else happened, completely unrelated to PrintReleaf
end
```


## Advanced Options

#### Logging

By default, PrintReleaf does not perform any logging. You may provide a logger for PrintReleaf to write to:

```ruby
require 'logger'
logger = Logger.new(STDOUT)
PrintReleaf.logger = logger
```

If you are using Rails, you can use the Rails logger:

```ruby
PrintReleaf.logger = Rails.logger
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/printreleaf/printreleaf-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

