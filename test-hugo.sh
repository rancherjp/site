#!/bin/sh
#////////////////////////////////////////////////
#/               CircleCI automatic page build
#/ [Site Update] Merge it to www.rancher.jp
#////////////////////////////////////////////////

commitMassage=`git log -n 1 --oneline --pretty=format:"%s"`





if [[ "$commitMassage" =~ \["Site Update"\] ]]; then
        cd ~/
        git add ./docs/ -A
        git commit -m "[ci skip] CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}
        echo "[Site Update] Merge it to www.rancher.jp is skipped..."
else
        echo "[Site Update] Merge it to www.rancher.jp is start..."
        cd ~/
        git clone git@github.com:rancherjp/rancherjp.github.io.git
        mv -v ~/site ~/rancherjp.github.io
        git commit -m "CircleCI automatic page build Time:[`date`]" || true
        git push origin ${GITHUB_BRANCH}
fi