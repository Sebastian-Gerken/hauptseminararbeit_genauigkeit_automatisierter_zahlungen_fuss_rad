# Trafficcount-cv-gt-evaluation


This script processes trafficevent data from OpenTrafficCam OTVision processed with OTAnalytic and Groundtruth data, and outputs a series of binary classification tests for each interval.

## Dependencies

- pandas
- numpy
- seaborn
- matplotlib
- re
- datetime

## Usage

1. Set the paths for the ground truth and evaluation datasets.
2. Adjust the interval settings as needed.
3. Run the script to process and analyze the data.

## Features

- Reads and processes data from multiple sources and formats.
- Filters data by datetime range.
- Compares and merges data from ground truth and evaluation datasets.
- Generates binary classification tests for specified intervals.
- Exports results to CSV files.

## Functions

- `sort_time()`: Sorts rows in a DataFrame by datetime.
- `filter_df_by_range()`: Filters a DataFrame by datetime range.
- `array_similar()`: Checks if two arrays contain the same strings.
- `get_gates()`: Checks if two DataFrames have identical values in a specified column.
- `get_value_counts()`: Returns value counts from a DataFrame for a specific section.
- `extract_time()`: Extracts the time from a file name in the format "...yyyy-mm-dd_HH-MM-SS.csv".
- `get_right_positive()`: Returns the minimum value from specified columns.
- `get_false_positive()`: Calculates the false positive value.
- `get_false_negative()`: Calculates the false negative value.
- `format_timedelta()`: Formats a timedelta object as a string.

## Example

```python
groundtruth = "data/gt_data/Saarbruecken_OTCamera04_FR20_2022-10-17_13-15-00.csv"
evaluate = "data/otv_data/Saarbruecken_OTCamera04_FR20_2022-10-17_13-15-00_events.csv"
filename = "Saarbruecken_1s_" + extract_time(groundtruth).strftime("%Y-%m-%d_%H-%M-%S")

t_min = extract_time(groundtruth)
t_max = t_min + pd.Timedelta(minutes=15)  # End time of the video
interval = pd.timedelta_range(start="0 days", end="15 minutes", freq="1 s")  # Interval
