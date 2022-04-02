#wget https://github.com/hashicorp/terraform-provider-aws/archive/refs/heads/main.zip
unzip main.zip

cp -r terraform-provider-aws-main/website/docs/r ./
cp -r terraform-provider-aws-main/website/docs/d ./

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


mkdir dash
mv *.html dash/
cp dashing.json dash/
cp -r github-markdown-css dash/

rm *.*asdf
echo "Done"
