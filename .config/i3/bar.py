import sys
import json
from time import localtime, strftime, sleep

# TODO .Xresources
DARK_BG = '#6d43a6'
LIGHT_BG = '#9a5feb'
BG = '#0e1019'

SEPARATOR = u'\uE0B2'


def write_and_flush(line):
    sys.stdout.write(line)
    sys.stdout.flush()


def get_date():
    result = strftime('%a %d.%m', localtime())
    return result.upper()


def get_time():
    return strftime('TIME %H:%M', localtime())


# TODO red when low
def get_battery():
    with open('/sys/class/power_supply/BAT1/capacity', 'r') as capacity_file:
        capacity = capacity_file.readline()
    return 'BAT ' + capacity.strip()


def get_cpu_temp():
    path = '/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input'
    with open(path, 'r') as cpu_file:
        temp = int(cpu_file.readline())
    temp = temp / 1000
    temp = int(temp)
    return 'CPU %d' % temp


def wrap_with_colored(blocks):
    result = []
    bg_current, bg_next = LIGHT_BG, DARK_BG

    start = {'name': 'start', 'full_text': SEPARATOR,
             'color': bg_current, 'background': BG}
    result.append(start)

    for i, block in enumerate(blocks):
        block['background'] = bg_current
        block['full_text'] = ' ' + block['full_text'] + ' '
        result.append(block)

        border = {'name': 'separator%d' % i, 'full_text': SEPARATOR,
                  'color': bg_next, 'background': bg_current}
        result.append(border)

        bg_current, bg_next = bg_next, bg_current

    result[-1]['color'] = BG
    return result


def make_initial_blocks(functions):
    result = []
    for i, function in enumerate(functions):
        block = {'name': 'block%d' % i, 'full_text': function(), 'color': BG}
        result.append(block)
    return result


def set_separators(blocks):
    for block in blocks:
        block['separator'] = False
        block['separator_block_width'] = 0


def main():
    write_and_flush('{"version": 1}')
    write_and_flush('[')

    while True:
        write_and_flush('[')

        blocks = make_initial_blocks(
            [get_cpu_temp, get_battery, get_date, get_time])
        blocks = wrap_with_colored(blocks)
        set_separators(blocks)

        raw = ','.join(map(json.dumps, blocks))
        write_and_flush(raw)
        write_and_flush('],')

        sleep(5)


if __name__ == '__main__':
    main()
