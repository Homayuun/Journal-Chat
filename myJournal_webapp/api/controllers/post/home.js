module.exports = async function(req,res) {
console.log('this is our homepage')
const userId = req.session.userId
const allPosts = await Post.find({user: userId});
if (req.wantsJSON) {
  return res.send(allPosts)
}
res.view('pages/home',
{allPosts}
)
}
