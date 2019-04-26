#BERT_NLP_Classification

[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)
[![Badge](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu/)
  
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

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/train.png)

## Fine tune Model
**modify build_model.sh**

```
vim build_model.sh
```

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/build_model.png)

```shell
export BERT_BASE_DIR={your project path}/BERT_BASE_DIR
export GLUE_DIR={your project path}/Project/transfer_learn/bert/git_version_bert/DATA_DIR
```
run

```
bash build_model.sh
```

The log will show the model performance and generate output_models folde.
Finding the checkpoint file with the largest tail number is the model after migration learning.

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/check.png)

##  performance
The performance is shown on our verification data set.

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/result.png)

This effect is better than the UIMFIT model. Here I also implemented the migration learning algorithm of UIMFIT on the same dataset.
# Prediction
modify test.tsv (drop label Column)

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/test_old.png)

run DEAL_WITH_TEST.ipynb

![Alt text](https://github.com/SkullFang/BERT_NLP_Classification/blob/master/image/test_new.png)

Of course, we can make the test.tsv file according to the above test.tsv and replace the original file.
run PREDICT.ipynb

#LICENSE
Copyright (c) <year> <copyright holders>

"Anti 996" License Version 1.0 (Draft)

Permission is hereby granted to any individual or legal entity
obtaining a copy of this licensed work (including the source code,
documentation and/or related items, hereinafter collectively referred
to as the "licensed work"), free of charge, to deal with the licensed
work for any purpose, including without limitation, the rights to use,
reproduce, modify, prepare derivative works of, distribute, publish
and sublicense the licensed work, subject to the following conditions:

1. The individual or the legal entity must conspicuously display,
without modification, this License and the notice on each redistributed
or derivative copy of the Licensed Work.

2. The individual or the legal entity must strictly comply with all
applicable laws, regulations, rules and standards of the jurisdiction
relating to labor and employment where the individual is physically
located or where the individual was born or naturalized; or where the
legal entity is registered or is operating (whichever is stricter). In
case that the jurisdiction has no such laws, regulations, rules and
standards or its laws, regulations, rules and standards are
unenforceable, the individual or the legal entity are required to
comply with Core International Labor Standards.

3. The individual or the legal entity shall not induce, suggest or force
its employee(s), whether full-time or part-time, or its independent
contractor(s), in any methods, to agree in oral or written form, to
directly or indirectly restrict, weaken or relinquish his or her
rights or remedies under such laws, regulations, rules and standards
relating to labor and employment as mentioned above, no matter whether
such written or oral agreements are enforceable under the laws of the
said jurisdiction, nor shall such individual or the legal entity
limit, in any methods, the rights of its employee(s) or independent
contractor(s) from reporting or complaining to the copyright holder or
relevant authorities monitoring the compliance of the license about
its violation(s) of the said license.

THE LICENSED WORK IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN ANY WAY CONNECTION WITH THE
LICENSED WORK OR THE USE OR OTHER DEALINGS IN THE LICENSED WORK.
