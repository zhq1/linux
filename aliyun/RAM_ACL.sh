#授权单独登陆某一个ECS  实例中为CRS-SVR  实例
{
  "Version": "1",
  "Statement": [
    {
      "Action": "ecs:*",
      "Resource": "acs:ecs:*:*:instance/CRS-SVR",
      "Effect": "Allow"
    },
    {
      "Action": "ecs:Describe*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "vpc:DescribeVpcs",
        "vpc:DescribeVSwitches"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}


#授权RDS单独实例登陆   实例名称为rm-2zew37vh885s1syn3
{
  "Version": "1",
  "Statement": [
    {
      "Action": "rds:*",
      "Resource": "acs:rds:*:*:dbinstance/rm-2zew37vh885s1syn3",
      "Effect": "Allow"
    },
    {
      "Action": "dms:LoginDatabase",
      "Resource": "acs:rds:*:*:*",
      "Effect": "Allow"
    }
  ]
}


#授权OSS单用户模式
{
    "Version": "1",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "oss:ListBuckets",
            "Resource": "acs:oss:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "oss:ListObjects",
                "oss:GetBucketAcl"
            ],
            "Resource": "acs:oss:*:*:shijisql-server"
        },
        {
            "Effect": "Allow",
            "Action": [
                "oss:GetObject",
                "oss:GetObjectAcl"
            ],
            "Resource": "acs:oss:*:*:shijisql-server/*"
        }
    ]
}