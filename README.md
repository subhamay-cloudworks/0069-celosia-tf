# Project Sedum: A Setp Function Demo

This is a simple demo of an AWS Step function using Lambda, DynamoDB, SQS Queue to show looping within a workflow.

## Description

This is a demo of a step function to loop through a list of items. In the first state a Lambda function inserts some quotes (with is passed as an input) to the DynamoDB table and returns a list of patrtition keys. The state machine then loops through the list and in each iteration fetches the quote from the DynamoDB table and pushes it to a SQS Queue.

The entire stack is created using HashiCorp Terraform.

![Project Celosia - Design Diagram](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0069-celosia/celosia-architecture-diagram.png)


### Installing

* Clone the repository.
* Create a S3 bucket to store the terraform state file.
* Create the folder - 0069-celosia/<environment devl,test,prod>
* Create a KMS Key for higher environment (test/prod) in the region where you want to deply the stack.
* Create the terraform.tfvars file with the appropriate variable values, a sample of it provided below:
    ```
    ######################################## Project Name ##############################################
    project_name = "celosia"
    ######################################## Environment Name ##########################################
    environment_name = "devl"
    ######################################## KMS Key ###################################################
    kms_key_alias = "alias/SB-KMS"
    kms_key_arn = {
    "us-east-1" = "arn:aws:kms:us-east-1:807724355529:key/e4c733c5-9fbe-4a90-bda1-6f0362bc9b89"
    "us-east-2" = "arn:aws:kms:us-east-2:807724355529:key/dfc9fe4a-7021-4eb8-a8e9-520a2f91f4f2"
    "us-west-2" = "arn:aws:kms:us-west-2:807724355529:key/2e99fc66-0257-4f12-841e-38dcddb71a84"
    }
    ######################################## DynamoDB Table ############################################
    dynamodb_table_base_name = "celosia-messages"
    partition_key            = "MessageId"
    partition_key_data_type  = "S"
    ######################################## SQS Queue #################################################
    sqs_queue_base_name       = "celosia-sqs-queue"
    delay_seconds             = 0
    max_message_size          = 262144
    message_retention_seconds = 345600
    receive_wait_time_seconds = 10
    ######################################## SNS Topic #################################################
    sns_topic_base_name    = "celosia-sns-topic"
    sns_topic_display_name = "SNS Topic to send a notification for CloudWatch Alarm"
    ######################################## SNS Topic Subscription ####################################
    sns_subscription_email = ["subhamay.aws@mailinator.com", "subhamay@mailinator.com"]
    ######################################## Lambda IAM Role / Policy ##################################
    lambda_iam_role_name   = "celosia-lambda-role"
    lambda_iam_policy_name = "celosia-lambda-policy"
    ######################################## Step Function IAM Role ####################################
    sf_iam_role_name   = "celosia-sf-role"
    sf_iam_policy_name = "celosia-sf-policy"
    ######################################## Lambda Function ###########################################
    lambda_function_base_name      = "celosia-seed-dynamodb"
    lambda_function_description    = "Celosia Lambda Function to seed the DynamoDB table with random values"
    memory_size                    = 256
    runtime                        = "python3.9"
    timeout                        = 300
    reserved_concurrent_executions = 1
    ```
* Modify the 01-provider.tf and change the S3 bucket to store the state region where you want to deploy the stack
* Run the following terraform commands from the projec directory:
    * terraform init
    * terraform validate
    * terraform plan
    * terraform apply -auto-approve
* To delete the stack run the following command:
    * terraform destroy -auto-approve

### Executing program

* Go to the Step Function Console and use the sample input and start the execution
* Step-by-step bullets
```
{
    "quotes":[
       "Age is an issue of mind over matter. If you don't mind, it doesn't matter.- Mark Twain",
       "Anyone who stops learning is old, whether at twenty or eighty. Anyone who keeps learning stays young. The greatest thing in life is to keep your mind young.- Henry Ford",
       "Wrinkles should merely indicate where smiles have been.- Mark Twain",
       "True terror is to wake up one morning and discover that your high school class is running the country.- Kurt Vonnegut",
       "A diplomat is a man who always remembers a woman's birthday but never remembers her age.- Robert Frost",
       "As I grow older, I pay less attention to what men say. I just watch what they do.- Andrew Carnegie",
       "How incessant and great are the ills with which a prolonged old age is replete.- C. S. Lewis",
       "Old age, believe me, is a good and pleasant thing. It is true you are gently shouldered off the stage, but then you are given such a comfortable front stall as spectator.- Confucius",
       "Old age has deformities enough of its own. It should never add to them the deformity of vice.- Eleanor Roosevelt",
       "Nobody grows old merely living a number of years. We grow old deserting our ideals. Years may wrinkle the skin, but to give up enthusiasm wrinkles the soul.- Samuel Ullman",
       "An archaeologist is the best husband a woman can have. The older she gets the more interested he is in her.- Agatha Christie",
       "All diseases run into one, old age.- Ralph Waldo Emerson",
       "Bashfulness is an ornament to youth, but a reproach to old age.- Aristotle",
       "Like everyone else who makes the mistake of getting older, I begin each day with coffee and obituaries.- Bill Cosby",
       "Age appears to be best in four things old wood best to burn, old wine to drink, old friends to trust, and old authors to read.- Francis Bacon",
       "None are so old as those who have outlived enthusiasm.- Henry David Thoreau",
       "Every man over forty is a scoundrel.- George Bernard Shaw",
       "Forty is the old age of youth fifty the youth of old age.- Victor Hugo",
       "You can't help getting older, but you don't have to get old.- George Burns",
       "Alas, after a certain age every man is responsible for his face.- Albert Camus",
       "Youth is when you're allowed to stay up late on New Year's Eve. Middle age is when you're forced to.- Bill Vaughan",
       "Old age is like everything else. To make a success of it, you've got to start young.- Theodore Roosevelt",
       "A comfortable old age is the reward of a well-spent youth. Instead of its bringing sad and melancholy prospects of decay, it would give us hopes of eternal youth in a better world.- Maurice Chevalier",
       "A man growing old becomes a child again.- Sophocles",
       "I will never be an old man. To me, old age is always 15 years older than I am.- Francis Bacon",
       "Age considers youth ventures.- Rabindranath Tagore"
    ]
 }
```

## Help

Post message in my blog (https://blog.subhamay.com)

## Authors

Contributors names and contact info

Subhamay Bhattacharyya  - [subhamay.aws@gmail.com](https://blog.subhamay.com)

## Reference
https://docs.aws.amazon.com/step-functions/latest/dg/sample-project-transfer-data-sqs.html

## Version History

* 0.1
    * Initial Release

## License

None

## Acknowledgments
AWS 

