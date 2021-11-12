value="$(cat scp_password.txt)"
sshpass -p "$value" scp build/app/outputs/apk/release/app-release.apk vizualize@192.168.11.198:/home/vizualize/thinkshops/server/webapp/circlestudio.apk
