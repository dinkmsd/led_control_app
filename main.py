import random
from datetime import datetime, timedelta

fixed_dimming_levels = [1, 3, 4, 5, 5, 4, 2]

# Tạo dữ liệu cho một ngày
def generate_day_data(dn):
    day_data = []
    # Từ 00:00 đến 05:00 (sáng mức 1)
    for hour in range(0, 6):
        power = round(random.uniform(16.7, 17.1), 1)  # Biến động +/- 0.2 W
        brightness = random.randint(805, 825)  # Biến động +/- 10 lm
        day_data.append((f"{hour:02}:00 {dn}", 1, power, brightness))
    # Từ 06:00 đến 16:00 (chiều mức 0)
    for hour in range(6, 17):
        power = 0  # Biến động +/- 0.5 W
        brightness = 0  # Biến động +/- 10 lm
        day_data.append((f"{hour:02}:00 {dn}", 0, power, brightness))
    # Từ 17:00 đến 23:00 (tối mức 1-5)
    for hour in range(17, 24):
        power = 0  # Biến động +/- 1.1 W
        brightness = 0  # Biến động +/- 10 lm
        dimming_level = 0
        if (hour == 17):
            dimming_level = fixed_dimming_levels[0]
        elif (hour == 18):
            dimming_level = fixed_dimming_levels[1]
        elif (hour == 19):
            dimming_level = fixed_dimming_levels[2]
        elif (hour == 20):
            dimming_level = fixed_dimming_levels[3]
        elif (hour == 21):
            dimming_level = fixed_dimming_levels[4]
        elif (hour == 22):
            dimming_level = fixed_dimming_levels[5]
        elif (hour == 23):
            dimming_level = fixed_dimming_levels[6]
            

        if (dimming_level == 0):
            power = 0  
            brightness = 0 
        if (dimming_level == 1):
            power = round(random.uniform(16.5, 17.4), 1)  
            brightness = random.randint(810, 830)  
        if (dimming_level == 2):
            power = round(random.uniform(42.0, 42.9), 1)  
            brightness = random.randint(7180, 7250)  
        if (dimming_level == 3):
            power = round(random.uniform(67.5, 68.5), 1)  
            brightness = random.randint(11250, 11350)  
        if (dimming_level == 4):
            power = round(random.uniform(99.2, 100.3), 1)  
            brightness = random.randint(14150, 14250)  
        if (dimming_level == 5):
            power = round(random.uniform(122.5, 123.4), 1)  
            brightness = random.randint(16360, 16440)  
        
        day_data.append((f"{hour:02}:00 {dn}", dimming_level, power, brightness))
    return day_data

# Tạo dữ liệu cho 7 ngày
def generate_week_data():
    week_data = []
    today = datetime.now()
    # Ngày 1 là thứ 2 (Monday)
    monday = today - timedelta(days=today.weekday())
    for day in range(7):
        dn = ""
        if day == 0:
            dn = "Mo"
        elif day == 1:
            dn = "Tu"
        elif day == 2:
            dn = "We"
        elif day == 3:
            dn = "Th"
        elif day == 4:
            dn = "Fr"
        elif day == 5:
            dn = "Sa"
        elif day == 6:
            dn = "Su"
        day_data = generate_day_data(dn)
        day_name = (monday + timedelta(days=day)).strftime("%H:%M %a")
        day_name = day_name.replace("Mon", "Mo").replace("Tue", "Tu").replace("Wed", "We").replace("Thu", "Th").replace("Fri", "Fr").replace("Sat", "Sa").replace("Sun", "Su")
        week_data.append((day_name, day_data))
    return week_data

# In ra dữ liệu cho 7 ngày
week_data = generate_week_data()
for day, data in week_data:
    for hour, dimming_level, power, brightness in data:
        print(f"ChartData('{hour}', {brightness}),")
    print()
