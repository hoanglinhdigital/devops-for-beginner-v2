# Lab 3 – Nội dung build step "Execute shell" của job Freestyle lab03-variables
# Job có 3 parameter (APP_ENV, REGION, DRY_RUN), credential binding USERNAME/PASSWORD
# và global environment variable COMPANY_NAME.
echo "===== 1. Built-in variables ====="
echo "JOB_NAME     : ${JOB_NAME}"
echo "BUILD_NUMBER : ${BUILD_NUMBER}"
echo "BUILD_ID     : ${BUILD_ID}"
echo "BUILD_URL    : ${BUILD_URL}"
echo "WORKSPACE    : ${WORKSPACE}"
echo "JENKINS_HOME : ${JENKINS_HOME}"
echo "NODE_NAME    : ${NODE_NAME}"

echo "===== 2. Global environment variable ====="
echo "COMPANY_NAME : ${COMPANY_NAME}"

echo "===== 3. Job parameters ====="
echo "APP_ENV : ${APP_ENV}"
echo "REGION  : ${REGION}"
echo "DRY_RUN : ${DRY_RUN}"
if [ "${DRY_RUN}" = "true" ]; then
  echo "DRY_RUN = true -> chỉ in thông tin, không deploy."
else
  echo "Deploying to ${APP_ENV} in ${REGION}..."
fi

echo "===== 4. Credential variables ====="
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Password length: ${#PASSWORD}"
