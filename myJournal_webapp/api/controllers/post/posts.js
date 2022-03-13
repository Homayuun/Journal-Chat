
module.exports = async function(req,res) {
    const userId = req.session.userId
    const allPosts = await Post.find({user: userId});
    if (req.wantsJson) {
      return res.send(allPosts);
    }
  }
