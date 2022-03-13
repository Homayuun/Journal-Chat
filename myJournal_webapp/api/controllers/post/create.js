module.exports = {


  friendlyName: 'Create',


  description: 'Create post.',


  inputs: {
    title: {
      description: 'is da title yay!',
      type: 'string',required: true
    },
    postBody: {
      type: 'string', required: true
    }
  },


  exits: {

  },


  fn: async function (inputs) {

    console.log('we are inside post dir')

    const userId = this.req.session.userId
    console.log('THIS IS:',userId)
    await Post.create({title:inputs.title, body:inputs.postBody,user:userId})
    this.res.redirect('/home')
    // All done.
  }


};
