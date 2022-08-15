apt-get update -y 
apt-get upgrade -y
apt-get install python3-pip -y 
apt install cargo -y 
sudo apt-get install sublist3r
apt-get install dirsearch

# Go Path setup 
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/lib/go

#Installing httpx tool  
go install  github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "done"

# Installing naabu 
go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
echo "Done"

# Installing map-cidr
go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest

#Installing waybackurls tool 
go install github.com/tomnomnom/waybackurls@latest
echo "done"

#Installing subfinder tool 
go install  github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "done"

#Installing assetfinder tool
go install github.com/tomnomnom/assetfinder@latest
echo "done"

#Installing anew tool
go install github.com/tomnomnom/anew@latest
echo "done"

#Installing httprob tool
go install github.com/tomnomnom/httprobe@latest
echo "done"

#installing gf
go install github.com/tomnomnom/gf@latest
ehco "Done"

#installng qsreplace
go install github.com/tomnomnom/qsreplace@latest
echo "Done"

#installing httprobe
go install github.com/tomnomnom/httprobe@latest
ehco "Done"


#Installing meg tool
go install github.com/tomnomnom/meg@latest


#Installing gau tool
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/bp0lr/gauplus@latest

@@ -43 28 +43 28 @@ echo "done"
GO111MODULE=on go install github.com/hahwul/dalfox/v2@latest
echo "done"


#Installing Haktrails Tool
go install -v github.com/hakluke/haktrails@latest


#Installing dnsx
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
echo "done"

# Installing chaos
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
echo "Done\n"

#Installing getJs tool
go get github.com/003random/getJS

#Installing github-subdomain tool
go install github.com/gwen001/github-subdomains@latest
echo "done"

#Installing gospider tool
go install github.com/jaeles-project/gospider@latest
echo "done"

Installing Kxss tool
#Installing Kxss tool
go install github.com/Emoe/kxss@latest
echo "done"

#Installing html-tool
go install github.com/tomnomnom/hacks/html-tool@latest
#Installing freq
go install https://github.com/takshal/freq@latest
echo "done"

#Installing hakrawler tool
go install github.com/hakluke/hakrawler@latest
#Installing subzy tool
go install -v github.com/lukasikic/subzy@latest
go install github.com/haccer/subjack@latest
echo "done"

# nuclei template
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
git clone https://github.com/projectdiscovery/nuclei-templates.git


#installing nrich
wget https://gitlab.com/api/v4/projects/33695681/packages/generic/nrich/latest/nrich_latest_amd64.deb
dpkg -i nrich_latest_amd64.deb

# Installing findomain
git clone https://github.com/findomain/findomain.git
cd findomain
cargo build --release
sudo cp target/release/findomain /usr/bin/
findomain

# cd $home/go/bin
# cp * /usr/local/bin

# @@ -85 5 +90 5 @@ cd findomain
# sudo cp target/release/findomain /usr/bin/


echo "Happy Hacking by @abdulx01"
