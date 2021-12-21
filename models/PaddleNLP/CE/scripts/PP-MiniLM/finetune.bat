@echo off
cd ../..

if not exist log\PP-MiniLM md log\PP-MiniLM
set logpath=%cd%\log\PP-MiniLM
set output_path=%cd%\models_repo\examples\model_compression\pp-minilm\general_distill\ernie-batchbatch-50w_400000\

cd models_repo\examples\model_compression\pp-minilm\finetuning

python -u ./run_clue.py --model_type ernie  --model_name_or_path %output_path% --task_name %3 --max_seq_length %6 --batch_size %5  --learning_rate %4 --num_train_epochs 1 --logging_steps 100 --seed 42  --save_steps  100 --warmup_proportion 0.1 --weight_decay 0.01 --adam_epsilon 1e-8 --output_dir %output_path%/models/%3/%4_%5/ --device %1 > %logpath%/finetune_%3_%4_%5_%1.log 2>&1

python export_model.py --model_type ernie --model_path %output_path%/models/%3/%4_%5  --output_path fine_tuned_infer_model/%3/float

if %ERRORLEVEL% == 1 (
    echo "exit_code: 1.0" >> %logpath%/finetune_%3_%4_%5_%1.log
) else (
    echo "exit_code: 0.0" >> %logpath%/finetune_%3_%4_%5_%1.log
)
