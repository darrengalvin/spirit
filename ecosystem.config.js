module.exports = {
  apps: [{
    name: 'spirit-yourcaio',
    script: 'npm',
    args: 'start',
    env: {
      PORT: 3008,
      NODE_ENV: 'production'
    }
  }]
};

