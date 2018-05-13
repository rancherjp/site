#!/bin/bash
#////////////////////////////////////////////////
#/               CircleCI automatic page build
#/ [Site Update] Merge it to www.rancher.jp
#////////////////////////////////////////////////


commitMessage=`git log -n 1 --oneline --pretty=format:"%s"`

if [[ "$commitMessage" =~ \["Site Update"\] ]]; then

        echo "[Site Update] Updating www.rancher.jp has started..."
        sed -i -e 's@https://www.rancher.jp/site/@https://www.rancher.jp/@g' config.toml
        sed -i -e '/noindex/d' config.toml
        hugo -d docs

        cd ~/
        git clone git@github.com:rancherjp/rancherjp.github.io.git
        cp -vrp ~/project/docs/* ~/rancherjp.github.io/
        cd ~/rancherjp.github.io
        git add . -A
        git commit -m "CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}

else

        echo "[Site Update] Updating www.rancher.jp has been skipped..."
        hugo -d docs
        git add ./docs/ -A
        git commit -m "[ci skip] CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}

fi
