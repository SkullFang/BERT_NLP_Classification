export BERT_BASE_DIR=/home/I348655/Document/Project/transfer_learn/bert/git_version_bert/BERT_BASE_DIR
export GLUE_DIR=/home/I348655/Document/Project/transfer_learn/bert/git_version_bert/DATA_DIR

python run_classifier.py \
  --task_name=mrpc \
  --do_train=true \
  --do_eval=true \
  --do_predict=true \
  --data_dir=$GLUE_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=2e-5 \
  --num_train_epochs=3.0 \
  --output_dir=output_models/
