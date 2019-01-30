# Introduction
Migration learning is already hot in the CV space. However, there has been no development in the NLP field. According to the theory, migration learning can be used in the NLP field. In October last year, Google sent a migration study paper in the NLP field: BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding. Although this is not the earliest paper in the field of NLP migration learning, the first papers are ELMo, fasiai's ULMFit and OpenAI's Transformer. Google created BERT based on predecessors, and BERT is much better than other models. Attention and transformer are mainly used in BERT. Detailed details can be seen in the original text.
Https://arxiv.org/abs/1810.04805
This project is fine-tuned on this basis, mainly modifying the run_classify.py file. Refer to this blog. https://mp.weixin.qq.com/s/XmeDjHSFI0UsQmKeOgwnyA
And the code has been modified to better suit our project needs.

# Environmental configuration
```
pip3 install -r requirements.txt
```

# Transfer Learning

## Download model
some detail
bert github
https://github.com/google-research/bert
### choose model
we choose pre-training model
BERT-Base, Uncased(https://storage.googleapis.com/bert_models/2018_10_18/uncased_L-12_H-768_A-12.zip): 12-layer, 768-hidden, 12-heads, 110M parameters
## Unzip model

unzip model to BERT_BASE_DIR folder
as 
>BERT_BASE_DIR/
>>bert_config.json
>>bert_model.ckpt.data-00000-of-00001
>>bert_model.ckpt.index
>>bert_model.ckpt.meta
>>vocab.txt
## Data preparation

Download the data on our server. The pymysql package is used. Do a simple stop word processing. And the data is divided into training data set train.tsv, val.tsv, test.tsv, and stored in the specified folder.
```
mkdir DATA_DIR
```

run GET_DATA.ipynb

For legal reasons, I am temporarily unable to disclose the data set. So I hidden the account password in the code. You can prepare the data set in the format I gave.

 The directory structure is as follows:
>DATA_DIR/
>>train.tsv
>>test.tsv
>>val.tsv

train.tsv  sample as：

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/train.png)

## Fine tune Model
**modify build_model.sh**

```
vim build_model.sh
```

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/build_model.png)

```shell
export BERT_BASE_DIR={your project path}/BERT_BASE_DIR
export GLUE_DIR={your project path}/Project/transfer_learn/bert/git_version_bert/DATA_DIR
```
The log will show the model performance and generate output_models folde.
Finding the checkpoint file with the largest tail number is the model after migration learning.

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/check.png)

##  performance
The performance is shown on our verification data set.

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/result.png)

This effect is better than the UIMFIT model. Here I also implemented the migration learning algorithm of UIMFIT on the same dataset.
# Prediction
modify test.tsv (drop label Column)

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/test_old.png)

run DEAL_WITH_TEST.ipynb

![Alt text](https://github.wdf.sap.corp/IPD-Integration/NLP_Machine_Learning/blob/master/BERT/image/test_new.png)

Of course, we can make the test.tsv file according to the above test.tsv and replace the original file.
run PREDICT.ipynb


