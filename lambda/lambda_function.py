import json
import boto3

def lambda_handler(event, context):
    # Create an S3 client
    s3_client = boto3.client('s3')
    
    # Loop through records in the event
    for record in event['Records']:
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        
        # Check if the object is in the /data folder
        if object_key.startswith('data/'):
            try:
                # Get the object
                response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
                object_content = response['Body'].read().decode('utf-8')
                
                # Process the object content (for example, log it)
                print(f"Object content from {object_key}:")
                print(object_content)
                
                # Add your custom processing logic here
                
            except Exception as e:
                print(f"Error getting object {object_key} from bucket {bucket_name}. Error: {e}")

    return {
        'statusCode': 200,
        'body': json.dumps('Processing completed.')
    }
