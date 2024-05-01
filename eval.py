import pandas as pd
from pathlib import Path
import subprocess
import re

params = {
    'dataQueueDepth'        :   4,
    'computeQueueDepth'     :   4,
    'vdmNumBanks'           :   4,
    'vlsPipelineDepth'      :   11,
    'numLanes'              :   4,
    'pipelineDepthMul'      :   12,
    'pipelineDepthAdd'      :   2,
    'pipelineDepthDiv'      :   8,
    'pipelineDepthShuffle'  :   5
}

tests = [
    'dot_product',
    'FCL',
    'conv2D',
    'FFT'
]

# numbanks = [4, 8, 16, 32, 64]
# lsPipelineDepth = [1, 2, 4, 6, 12]
# numbanks = [4]
# lsPipelineDepth = [1, 2, 4, 6, 12]
# queueDepth = [1, 2, 4, 8, 16, 32]

computePipelineDepth = [
    {
        'div': 1,
        'mul': 4
    },
    {
        'div': 2,
        'mul': 6
    },
    {
        'div': 4,
        'mul': 8
    },
    {
        'div': 6,
        'mul': 10
    },
    {
        'div': 8,
        'mul': 12
    }
]


def create_config(eval_params, iodir: Path):
    with open(iodir.joinpath('Config.txt'), 'w') as f:
        for param, value in eval_params.items():
            f.write(f'{param} = {value}\n')


def main():
    eval_runs = []
    test_dir = Path('tests')
    for test in tests:
        iodir = test_dir.joinpath(test)
        print(f'running test {test}')
        # for numbank in numbanks:
        #     for depth in lsPipelineDepth:
        #         eval_run = params.copy()
        #         eval_run['test'] = test
        #         eval_run['vlsPipelineDepth'] = depth
        #         eval_run['vdmNumBanks'] = numbank
        #         create_config(eval_run, iodir)
        #         run_output = subprocess.check_output(['./run_timing.sh', iodir.__str__()], text=True)
        #         timing_out = run_output.splitlines()[-1]
        #         match = re.match(r'total cycles: (?P<num_cycles>[0-9]+)', timing_out)
        #         if match is None:
        #             raise Exception()
        #         eval_run['numCycles'] = match.groupdict()['num_cycles']
        #         eval_runs.append(eval_run)
        # for depth in queueDepth:
        #     eval_run = params.copy()
        #     eval_run['test'] = test
        #     eval_run['computeQueueDepth'] = depth
        #     eval_run['dataQueueDepth'] = depth
        #     create_config(eval_run, iodir)
        #     run_output = subprocess.check_output(['./run_timing.sh', iodir.__str__()], text=True)
        #     timing_out = run_output.splitlines()[-1]
        #     match = re.match(r'total cycles: (?P<num_cycles>[0-9]+)', timing_out)
        #     if match is None:
        #         raise Exception()
        #     eval_run['numCycles'] = match.groupdict()['num_cycles']
        #     eval_runs.append(eval_run)
        for depth in computePipelineDepth:
            eval_run = params.copy()
            eval_run['test'] = test
            eval_run['pipelineDepthDiv'] = depth['div']
            eval_run['pipelineDepthMul'] = depth['mul']
            create_config(eval_run, iodir)
            run_output = subprocess.check_output(['./run_timing.sh', iodir.__str__()], text=True)
            timing_out = run_output.splitlines()[-5]
            match = re.match(r'total cycles: (?P<num_cycles>[0-9]+)', timing_out)
            if match is None:
                raise Exception()
            eval_run['numCycles'] = match.groupdict()['num_cycles']
            eval_runs.append(eval_run)
            print(f'done {depth}')

    df = pd.DataFrame(eval_runs)
    df.to_csv('eval.csv')


if __name__ == '__main__':
    main()
