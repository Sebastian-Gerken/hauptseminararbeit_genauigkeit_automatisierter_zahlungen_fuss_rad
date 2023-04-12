def sort_time(df, col="DateTime"):
    """Sorts rows in dataframe by datetime"""
    df[col] = pd.to_datetime(df[col])
    filtered = df.sort_values(by=col)
    return filtered

def filter_df_by_range(df, t_min, t_max, col="DateTime"):
    """Filters dataframe by datetime range"""
    filtered = df[(df[col] >= t_min) & (df[col] < t_max)]
    return filtered

def array_similar(array1, array2):
    """Checks if 2 arrays contain the same strings"""
    if not len(array1) == len(array2):
        raise ValueError("Arrays don't have the same length!")
    for word in array1:
        if word in array2:
            continue
        else:
            raise ValueError("Arrays don't contain the same strings")
    return True

def get_gates(df1, df2, col="SectionID"):
    """Checks if two dataframes have identical values in column"""
    df1 = df1[col].unique()
    df2 = df2[col].unique()
    if array_similar(df1, df2):
        return df1
    else:
        raise ValueError("Dataframes have different values in the column")

def get_value_counts(df, sections, section_index, value="Class", section_name="SectionID"):
    """Returns value counts from dataframe for a specific section"""
    return df.loc[df[section_name] == sections[section_index], value].value_counts()

def extract_time(file_path):
    """
    Extracts the time from file name in the format "...yyyy-mm-dd_HH-MM-SS.csv".
    
    Args:
    file_path (str): The file path to extract the time from
    
    Returns:
    datetime.datetime object: The time extracted from the file name
    """
    pattern = r"(\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2})"
    match = re.search(pattern, file_path)
    if match:
        time_str = match.group(1)
        return datetime.datetime.strptime(time_str, '%Y-%m-%d_%H-%M-%S')
    else:
        return None

def get_right_positive(row, columns):
    return row[columns].min()

def get_false_positive(row, gt, eval):
    diff = row[gt] - row[eval]
    if diff < 0:
        return abs(diff)
    else:
        return 0
    
def get_false_negative(row, gt, eval):
    diff = row[gt] - row[eval]
    if diff > 0:
        return abs(diff)
    else:
        return 0
    
def format_timedelta(td):
    total_seconds = int(td.total_seconds())
    hours, remainder = divmod(total_seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    return f'{hours:02d}_{minutes:02d}_{seconds:02d}'