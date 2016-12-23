#!/bin/sh
#////////////////////////////////////////////////
#/               CircleCI automatic page build
#/ [Site Update] Merge it to www.rancher.jp
#////////////////////////////////////////////////

commitMassage=`git log -n 1 --oneline --pretty=format:"%s"`


if [[ "$commitMassage" =~ \["Site Update"\] ]]; then

        echo "[Site Update] Merge it to www.rancher.jp is skipped..."
        hugo -d docs
        git add ./docs/ -A
        git commit -m "[ci skip] CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}

else

        echo "[Site Update] Merge it to www.rancher.jp is start..."
        sed -i -e 's@http://www.rancher.jp/site/@http://www.rancher.jp/@g' config.toml
        sed -i -e '/noindex/d' config.toml
        hugo -d docs

        cd ~/
        git clone git@github.com:rancherjp/rancherjp.github.io.git
        cp -vrp ~/site/docs/* ~/rancherjp.github.io/
        cd ~/rancherjp.github.io
        git add . -A
        git commit -m "CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}

fi