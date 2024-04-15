Connect to hpc and load python, then create a python virtual environment 

```bash
si
module load lang/Python #Loading default Python
python -m venv jupyter_env
source jupyter_env/bin/activate
python -m pip install --upgrade pip
python -m pip install jupyter ipykernel
```

This next command makes sure the environment would be a valid kernel

```bash
python -m ipykernel install --sys-prefix --name jupyter_env
```

exit the interactive shell:

```bash
exit
```

```bash
curl -L https://raw.githubusercontent.com/HesamKorki/scripts/main/jupyter-on-slurm/start-jupyter.sh -o start-jupyter.sh
```

Make the file executable:

```bash
chmod +x start-jupyter.sh
```

Now, each time you want to use jupyter:

```bash
sbatch start-jupyter.sh
```

Then check the content of the file notebook.log to get the command that you need to perform in a separate terminal on your PC and the token that jupyter needs

```bash
cat notebook.log
```

copy the ssh command on your PC and wait for 10 seconds.

in a browser type in http://localhost:8888

Viola!
