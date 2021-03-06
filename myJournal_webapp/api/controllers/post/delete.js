module.exports = {


  friendlyName: 'Delete',


  description: 'Delete post.',


  inputs: {
    postId: {
      type: 'string', required: true
    }

  },


  exits: {
    invalid:{
      description: 'invalid post to delete'
    }

  },


  fn: async function (inputs) {
  const record = await Post.destroy({id: inputs.postId}).fetch()
  if (record.length == 0) {
    throw({invalid:{error: 'record does not exist'}})
  }
    // All done.
    return record;

  }


};
