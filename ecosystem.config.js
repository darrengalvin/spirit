module.exports = {
  apps: [
    {
      name: 'spirit-yourcaio',
      script: 'node_modules/.bin/next',
      args: 'start',
      cwd: '/var/www/vhosts/yourcaio.co.uk/spirit',
      env: {
        NODE_ENV: 'production',
        PORT: 3005
      },
    }
  ]
};