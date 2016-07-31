// # Ghost Configuration
// Setup your Ghost install for various [environments](http://support.ghost.org/config/#about-environments).
// Ghost runs in `development` mode by default. Full documentation can be found at http://support.ghost.org/config/
var path = require('path'),
    config;

function getContentPath( directory ) {
  var rootPath = process.env.GHOST_CONTENT || __dirname;
  return path.join(rootPath, directory);
}

function getDatabaseOptions() {
  switch ( process.env.DB_CLIENT ) {
    case 'mysql':
      return {
        client: process.env.DB_CLIENT,
        connection: {
          host     : process.env.DB_HOST      || '127.0.0.1',
          user     : process.env.DB_USER      || 'your_database_user',
          password : process.env.DB_PASSWORD  || 'your_database_password',
          database : process.env.DB_NAME      || 'ghost_db',
          charset  : 'utf8'
        },
        pool: {
          min      : process.env.DB_POOL_MIN  || 2,
          max      : process.env.DB_POOL_MAX  || 10
        },
        debug: !!process.env.DEBUG
      };
    default: // sqlite3
      return {
        client: 'sqlite3',
        connection: {
          filename: getContentPath( '/data/ghost.db' )
        },
        debug: !!process.env.DEBUG
      };
  }
}

config = {
    production: {
        url: process.env.URI_BASE || 'http://localhost:2368',
        mail: {
          from: process.env.MAIL_FROM || '',
          transport: process.env.MAIL_TRANSPORT || '',
          options: {
              service: process.env.MAIL_SERVICE || '',
              auth: {
                  user: process.env.MAIL_AUTH_USER || '',
                  pass: process.env.MAIL_AUTH_PASS || ''
              }
          }
        },
        database: getDatabaseOptions(),
        server: {
            host: process.env.GHOST_HOST || '0.0.0.0',
            port: process.env.GHOST_PORT || '2368'
        },
        paths: {
            contentPath: getContentPath( '/' )
        }
    },
    development: {
        url: process.env.URI_BASE || 'http://127.0.0.1:2368',
        mail: {
          from: process.env.MAIL_FROM || '',
          transport: process.env.MAIL_TRANSPORT || '',
          options: {
              service: process.env.MAIL_SERVICE || '',
              auth: {
                  user: process.env.MAIL_AUTH_USER || '',
                  pass: process.env.MAIL_AUTH_PASS || ''
              }
          }
        },
        database: getDatabaseOptions(),
        server: {
            host: process.env.GHOST_HOST || '0.0.0.0',
            port: process.env.GHOST_PORT || '2368'
        },
        paths: {
            contentPath: getContentPath( '/' )
        }
    }
};

module.exports = config;
