
def split_weeks(start_date, end_date)
  _result = []

  if start_date > end_date
    return _result
  end

  _current = start_date

  while true
    # Save current date to result.
    _result.push _current
    _next = _current.next_week
    if _next <= end_date
      _current = _next
    else
      break
    end
  end

  _result
end

