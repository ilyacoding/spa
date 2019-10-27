# Steam Prices Analyzing tool

Tools, which can help you to analyze skins prices on steam marketplace.

## Installation

Run the following command

```ruby
docker-compose build
```

And then generate master key and fill credentials file.

    $ master.key

## Usage

Run infrastructure:

    $ docker-compose up

## Volume backup

    $ docker run --rm --volumes-from spa_clickhouse_1 -v $(pwd):/backup busybox tar cvf /backup/clickhouse-db.tar /var/lib/clickhouse
