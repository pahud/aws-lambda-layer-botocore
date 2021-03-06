[![](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiRVM5ckpBWGJEZ3FwbXExdklnNmQ1cHpvclVMQ01OSEU3NnVBRGFsc0EyMUVVazN6VkxodmtvSnJ1L21KK0Fjd01OaDM1bDhuOGdrVElxTXhpZHdJQVowPSIsIml2UGFyYW1ldGVyU3BlYyI6ImV3MDlKbDRPdUhPajZiVzIiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:903779448426:applications~lambda-layer-botocore)
[![](https://img.shields.io/badge/Available-serverless%20app%20repository-blue.svg)](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:903779448426:applications~lambda-layer-botocore)



# AWS Lambda Layer for botocore with Python3

This repo builds the latest `botocore` with python3 into AWS Lambda Layer and publishes to [AWS SAR](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:903779448426:applications~lambda-layer-botocore). We automate the daily build the publish to SAR with CodeBuild.


## CDK Sample


```js
const samApp = new sam.CfnApplication(this, 'SamLayer', {
  location: {
    applicationId: 'arn:aws:serverlessrepo:us-east-1:903779448426:applications/lambda-layer-botocore',
    semanticVersion: '1.13.26'
  },
  parameters: {
    LayerName: `${this.stackName}-botocore-lambdaLayer`
  }
})

const layerVersionArn = samApp.getAtt('Outputs.LayerVersionArn').toString();

const handler = new lambda.Function(this, 'Func', {
  code: lambda.AssetCode.fromInline(`
import botocore, json
def handler(event, context):
  return {
    'statusCode': 200,
    'body': json.dumps(botocore.__version__)
  }`),
  runtime: lambda.Runtime.PYTHON_3_7,
  handler: 'index.handler',
  layers: [
    lambda.LayerVersion.fromLayerVersionArn(this, 'Layer', layerVersionArn)
  ]
})

new apigateway.LambdaRestApi(this, 'Api', {
  handler
})

new cdk.CfnOutput(this, 'LayerVersionArn', {
  value: layerVersionArn
})
```
view full sample at [play-with-cdk](https://play-with-cdk.com?s=ca57c2a6e22102c4ce714f830d0309e2)

