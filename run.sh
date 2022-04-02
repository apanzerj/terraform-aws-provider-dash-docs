wget https://github.com/hashicorp/terraform-provider-aws/archive/refs/heads/$1.zip
unzip $1.zip

cp -r terraform-provider-aws-$1/website/docs/r ./
cp -r terraform-provider-aws-$1/website/docs/d ./
cp -r terraform-provider-aws-$1/website/docs/index.html.markdown ./

echo "Creating resources.html.markdown"
cat r/*.markdown > resources.html.markdown
echo "Creating data_sources.html.markdown"
cat d/*.markdown > data_sources.html.markdown

echo "Converting HCL to Terraform for code fences"
sed -i'asdf' 's/```hcl/```terraform/gI' data_sources.html.markdown
sed -i'asdf' 's/```hcl/```terraform/gI' resources.html.markdown

echo "Converting resources.html.markdown to html"
python -m gh_md_to_html -o OFFLINE resources.html.markdown
echo "Converting data_sources.html.markdown to html"
python -m gh_md_to_html -o OFFLINE data_sources.html.markdown
echo "Converting index.html.markdown to html"
python -m gh_md_to_html -o OFFLINE index.html.markdown

mv data_sources.html.html data_sources.html
mv resources.html.html resources.html
mv index.html.html index.html

echo "Fixing CSS issue"
sed -i'asdf' 's/\/github-markdown-css/github-markdown-css/g' data_sources.html
sed -i'asdf' 's/\/github-markdown-css/github-markdown-css/g' resources.html
sed -i'asdf' 's/\/github-markdown-css/github-markdown-css/g' index.html

rm data_sources.html.markdown
rm resources.html.markdown

mkdir dash-$1
mv *.html dash-$1/
cp dashing.json dash-$1/
cp -r github-markdown-css dash-$1/

rm *.*asdf
echo "Done"
