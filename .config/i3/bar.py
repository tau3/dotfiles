import time
import sys
import json
from time import localtime, strftime

# TODO .Xresources
DARK_BG = '#6d43a6'
LIGHT_BS = '#9a5feb'
BG = '#0e1019'

LEFT_SEPARATOR_FILLED = u'\uE0B2'


def wirte_and_flush(line):
    sys.stdout.write(line)
    sys.stdout.flush()


def get_date():
    return strftime('DATE %d.%m.%Y ', localtime())
    # return strftime(u'\uF073 %d.%m.%Y ', localtime())


def get_time():
    return strftime('TIME %H:%M', localtime())
    # return strftime(u'\uF017 %H:%M', localtime())


def get_battery():
    with open('/sys/class/power_supply/BAT1/capacity', 'r') as f:
        capacity = f.readline()
    return 'BAT ' + capacity.strip()
    # return u'\uF578 ' + capacity.strip()


def get_cpu_temp():
    path = '/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input'
    with open(path, 'r') as f:
        temp = int(f.readline())
    temp = temp / 1000
    temp = int(temp)
    return 'CPU ' + str(temp)
    # return u'\uF2DB' + str(temp)


def wrap_with_colored(blocks):
    result = []
    i = 0
    bg_current, bg_next = LIGHT_BS, DARK_BG
    left = {'name': 'l' + str(i), 'full_text': LEFT_SEPARATOR_FILLED, 'color': bg_current, 'background': BG}
    result.append(left)
    for block in blocks:
        result.append(block)
        block['background'] = bg_current
        block['full_text'] = ' ' + block['full_text'] + ' '
        block['color'] = BG
        right = {'name': 'r' + str(i), 'full_text': LEFT_SEPARATOR_FILLED, 'color': bg_next, 'background': bg_current}
        bg_current, bg_next = bg_next, bg_current
        result.append(right)
        i += 1
    result[-1]['color'] = BG
    return result


def main():
    wirte_and_flush('{"version": 1}')
    wirte_and_flush('[')

    while(True):
        wirte_and_flush('[')
        temp = {'name': 'temp', 'full_text': get_cpu_temp()}
        battery = {'name': 'battery', 'full_text': get_battery()}
        date = {'name': 'date', 'full_text': get_date()}
        current_time = {'name': 'time', 'full_text': get_time()}

        blocks = [temp, battery, date, current_time]
        blocks = wrap_with_colored(blocks)
        for block in blocks:
            block['separator'] = False
            block['separator_block_width'] = 0
        raw = ','.join(map(lambda b: json.dumps(b), blocks))
        wirte_and_flush(raw)
        wirte_and_flush('],')
        time.sleep(1)


if __name__ == '__main__':
    main()
