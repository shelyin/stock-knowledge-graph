#!/bin/bash

# 设置Neo4j导入命令
neo4j_import_command="E:\Neo4j\neo4j-community-3.5.28\bin\neo4j-admin.bat import"

# 设置数据库名
database_name="test_stock.db"

# 设置节点和关系文件路径
node_files=(
  "E:\Neo4j\neo4j-community-3.5.28\import\executive.csv"
  "E:\Neo4j\neo4j-community-3.5.28\import\stock.csv"
  "E:\Neo4j\neo4j-community-3.5.28\import\concept.csv"
  "E:\Neo4j\neo4j-community-3.5.28\import\industry.csv"
)

relationship_files=(
  "E:\Neo4j\neo4j-community-3.5.28\import\executive_stock.csv"
  "E:\Neo4j\neo4j-community-3.5.28\import\stock_concept.csv"
  "E:\Neo4j\neo4j-community-3.5.28\import\stock_industry.csv"
)

# 构建导入命令
for node_file in "${node_files[@]}"; do
  if [[ -f "${node_file}" ]]; then
    neo4j_import_command+=" --nodes=${node_file}"
  else
    echo "节点文件 ${node_file} 不存在"
    exit 1
  fi
done

for relationship_file in "${relationship_files[@]}"; do
  if [[ -f "${relationship_file}" ]]; then
    neo4j_import_command+=" --relationships=${relationship_file}"
  else
    echo "关系文件 ${relationship_file} 不存在"
    exit 1
  fi
done

# 执行导入命令
${neo4j_import_command} --database=${database_name}

#neo4j-admin import \
#    --database=test_stock.db \
#    --ignore-duplicate-nodes=true \
#    --ignore-missing-nodes=true \
#    --id-type=string \
#    --nodes=data/import/executive.csv \
#    --nodes=data/import/stock.csv \
#    --nodes=data/import/industry.csv \
#    --nodes=data/import/concept.csv \
#    --relationships=data/import/executive_stock.csv \
#    --relationships=data/import/stock_industry.csv \
#    --relationships=data/import/stock_concept.csv