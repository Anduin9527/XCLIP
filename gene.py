import yaml
import os
path = './configs/rader27/gene.yaml'
val_path ='./data/Split/split/'
# 读取 YAML 文件
with open(path, 'r') as file:
    data = yaml.safe_load(file)
    
for i in range(0, 27):
  # 修改 YAML 数据
  data['DATA']['VAL_FILE'] = val_path + str(i) + '.txt'
  # 将修改后的数据写回文件
  with open(path, 'w') as file:
      yaml.safe_dump(data, file)
      
  # 执行命令
  cmd = f'python -m torch.distributed.launch --nproc_per_node=1 main.py  -cfg configs/rader27/gene.yaml --only_gene --ID {i*32} --resume /hy-tmp/xclip_log/ckpt_epoch_34.pth   --opts TEST.NUM_CLIP 1 TEST.NUM_CROP 1'
  os.system(cmd)