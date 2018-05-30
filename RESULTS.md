# Results

This page contains results of running all the benchmarks using different adapters. The values reported are iterations per second, thus higher numbers indicate better performance.

The tests were run in two batches. One batch connected to localhost back ends (adapters not marked \_net) while the other connected to remote back ends (adapters marked \_net). Rather than changing the back end and running the tests again, instead the machine that ran the tests was changed and the back end was kept the same desktop Ubuntu machine. This was done because these benchmarks are more about the back end and the connection to it rather than the performance of the code running on the front end.

All back ends were left at the default settings they come in in Ubuntu. Fcrepo\_wrapper was used for Fedora.

Note that in nearly all cases the standard deviation of iteration duration is quite high so small changes may be attributable to randomness rather than any real difference in performance.


## Description of benchmarks

For detailed descriptions, see the source code in ```lib/valkyrie_benchmark/tests```.

| Test | Notes |
| ---- | ----- |
| basic_metadata_tests create_stub | Create a single small resource with a title but no other data. |
| basic_metadata_tests create_with_text | Create a single resource with a title and a long text field but no other data. |
| basic_metadata_tests create_with_many_fields | Create a single resource with many different data fields present. |
| basic_metadata_tests update_stub | Update a small rerource. |
| basic_metadata_tests update_with_text | Update a resource with a long text field. |
| basic_metadata_tests update_with_many_fields | Update a resource with many data fields. |
| basic_metadata_tests delete_stubs | Delete a small resource. |
| basic_metadata_tests delete_with_many_fields | Delete a resource with many data fields. |
| member_tests create_parent | Create a resource with 100 member\_ids. Creating members not inluded. |
| member_tests reload_parent | Reload the parent resource which has 100 member\_ids. Does not include loading the members, only the parent resource with a list of member_ids. |
| member_tests update_child | Update the title of one of the members of the parent resource. |
| member_tests update_parent | Update the title of the parent resource. |
| member_tests one_more_page | Add one more member to the parent resource that already has 100 member\_ids. |
| member_tests remove_page | Remove one of the members from the parent. Does not remove the member resource itself, only its id from the member_ids of the parent. |
| member_tests find_parents | Find the single parent resource of one of the members. |
| member_tests find_members | Find the 100 members of the parent resource.|
| alternate_id_tests create | Create a resource with two alternate\_ids. |
| alternate_id_tests find | Find a resource using one of its alternate\_ids. |

## Benchmark results

| Adapter                        |iterations/s | std.dev. |  iterations |time (s)|
| ------------------------------ | -----------:| --------:| -----------:| ------:|
| **basic_metadata_tests create_stub**                                       |||||
| active_record_mysql            |     38.113  | (±39.6%) |    192.000  |  5.038 |
| active_record_mysql_net        |     15.672  | (±35.6%) |     79.000  |  5.041 |
| active_record_postgres         |     72.286  | (±20.4%) |    366.000  |  5.063 |
| active_record_postgres_net     |     34.571  | (±29.5%) |    177.000  |  5.120 |
| active_record_sqlite           |     17.078  | (±35.8%) |     88.000  |  5.153 |
| postgres                       |     88.485  | (±31.3%) |    448.000  |  5.063 |
| postgres_net                   |     64.908  | (±27.6%) |    327.000  |  5.038 |
| fedora                         |    109.660  | (± 9.0%) |    550.000  |  5.015 |
| fedora_net                     |     78.438  | (±11.3%) |    399.000  |  5.087 |
| redis                          |      3.955k | (± 9.9%) |     19.890k |  5.030 |
| memory                         |      5.720k | (±12.5%) |     28.861k |  5.046 |
| **basic_metadata_tests create_with_text**                                  |||||
| active_record_mysql            |     31.038  | (±28.7%) |    156.000  |  5.026 |
| active_record_mysql_net        |     16.558  | (±33.1%) |     83.000  |  5.013 |
| active_record_postgres         |     67.626  | (±25.8%) |    343.000  |  5.072 |
| active_record_postgres_net     |     28.099  | (±34.2%) |    141.000  |  5.018 |
| active_record_sqlite           |     18.499  | (±30.0%) |     93.000  |  5.027 |
| postgres                       |     85.288  | (±11.4%) |    432.000  |  5.065 |
| postgres_net                   |     37.441  | (±26.8%) |    188.000  |  5.021 |
| fedora                         |     96.703  | (±10.2%) |    490.000  |  5.067 |
| fedora_net                     |     78.915  | (± 5.1%) |    399.000  |  5.056 |
| redis                          |      3.728k | (± 9.0%) |     19.027k |  5.104 |
| memory                         |      5.263k | (±17.3%) |     26.488k |  5.033 |
| **basic_metadata_tests create_with_many_fields**                           |||||
| active_record_mysql            |     22.561  | (±38.9%) |    120.000  |  5.319 |
| active_record_mysql_net        |     17.385  | (±25.7%) |     87.000  |  5.004 |
| active_record_postgres         |     71.423  | (±28.7%) |    360.000  |  5.040 |
| active_record_postgres_net     |     32.354  | (±28.4%) |    168.000  |  5.193 |
| active_record_sqlite           |     17.259  | (±34.6%) |     87.000  |  5.041 |
| postgres                       |     75.479  | (±18.5%) |    400.000  |  5.299 |
| postgres_net                   |     41.054  | (±22.7%) |    207.000  |  5.042 |
| fedora                         |     39.488  | (±22.7%) |    208.000  |  5.267 |
| fedora_net                     |     40.848  | (±11.9%) |    208.000  |  5.092 |
| redis                          |      2.349k | (±20.6%) |     11.782k |  5.016 |
| memory                         |      3.324k | (±19.0%) |     17.802k |  5.355 |
| **basic_metadata_tests update_stub**                                       |||||
| active_record_mysql            |     31.431  | (±42.4%) |    159.000  |  5.059 |
| active_record_mysql_net        |     16.957  | (±26.6%) |     85.000  |  5.013 |
| active_record_postgres         |     45.230  | (±35.0%) |    270.000  |  5.969 |
| active_record_postgres_net     |     32.705  | (±28.7%) |    164.000  |  5.014 |
| active_record_sqlite           |     18.679  | (±33.7%) |     94.000  |  5.032 |
| postgres                       |     94.477  | (±20.5%) |    480.000  |  5.081 |
| postgres_net                   |     69.468  | (±24.2%) |    350.000  |  5.038 |
| fedora                         |     55.453  | (±14.0%) |    280.000  |  5.049 |
| fedora_net                     |     46.606  | (± 6.4%) |    236.000  |  5.064 |
| redis                          |      5.577k | (±13.2%) |     27.999k |  5.020 |
| memory                         |      9.421k | (±11.7%) |     47.824k |  5.076 |
| **basic_metadata_tests update_with_text**                                  |||||
| active_record_mysql            |     35.397  | (±35.6%) |    178.000  |  5.029 |
| active_record_mysql_net        |     17.121  | (±37.1%) |     86.000  |  5.023 |
| active_record_postgres         |     63.838  | (±29.9%) |    320.000  |  5.013 |
| active_record_postgres_net     |     33.534  | (±24.9%) |    168.000  |  5.010 |
| active_record_sqlite           |     13.235  | (±42.1%) |     68.000  |  5.138 |
| postgres                       |     73.245  | (±18.9%) |    371.000  |  5.065 |
| postgres_net                   |     37.091  | (±36.9%) |    186.000  |  5.015 |
| fedora                         |     49.066  | (±15.7%) |    250.000  |  5.095 |
| fedora_net                     |     45.543  | (± 6.6%) |    228.000  |  5.006 |
| redis                          |      3.713k | (±26.0%) |     18.860k |  5.079 |
| memory                         |      7.350k | (±25.0%) |     37.229k |  5.065 |
| **basic_metadata_tests update_with_many_fields**                           |||||
| active_record_mysql            |     33.944  | (±40.1%) |    172.000  |  5.067 |
| active_record_mysql_net        |     15.102  | (±24.4%) |     76.000  |  5.032 |
| active_record_postgres         |     66.903  | (±25.3%) |    335.000  |  5.007 |
| active_record_postgres_net     |     30.156  | (±32.4%) |    154.000  |  5.107 |
| active_record_sqlite           |     15.157  | (±40.4%) |     76.000  |  5.014 |
| postgres                       |     68.662  | (±23.3%) |    350.000  |  5.097 |
| postgres_net                   |     33.866  | (±26.3%) |    175.000  |  5.167 |
| fedora                         |     15.148  | (±22.5%) |     81.000  |  5.347 |
| fedora_net                     |     16.128  | (± 6.2%) |     81.000  |  5.022 |
| redis                          |      3.349k | (±13.1%) |     17.004k |  5.077 |
| memory                         |      5.166k | (±14.2%) |     26.448k |  5.120 |
| **basic_metadata_tests delete_stubs**                                      |||||
| active_record_mysql            |     35.780  | (±38.5%) |    180.000  |  5.031 |
| active_record_mysql_net        |     16.288  | (±32.4%) |     82.000  |  5.034 |
| active_record_postgres         |     70.777  | (±25.2%) |    356.000  |  5.030 |
| active_record_postgres_net     |     34.754  | (±57.8%) |    175.000  |  5.035 |
| active_record_sqlite           |     17.129  | (±38.2%) |     90.000  |  5.254 |
| postgres                       |     74.981  | (±17.9%) |    376.000  |  5.015 |
| postgres_net                   |     57.063  | (±35.8%) |    290.000  |  5.082 |
| fedora                         |     64.589  | (±17.8%) |    324.000  |  5.016 |
| fedora_net                     |     54.822  | (± 5.5%) |    275.000  |  5.016 |
| redis                          |     11.271k | (± 1.7%) |     56.927k |  5.051 |
| memory                         |     17.494k | (± 2.3%) |     90.550k |  5.176 |
| **basic_metadata_tests delete_with_many_fields**                           |||||
| active_record_mysql            |     33.535  | (±44.7%) |    172.000  |  5.129 |
| active_record_mysql_net        |     15.777  | (±42.3%) |     79.000  |  5.007 |
| active_record_postgres         |     75.172  | (±41.5%) |    380.000  |  5.055 |
| active_record_postgres_net     |     47.536  | (±42.5%) |    240.000  |  5.049 |
| active_record_sqlite           |     15.883  | (±44.0%) |     82.000  |  5.163 |
| postgres                       |     77.681  | (±17.6%) |    392.000  |  5.046 |
| postgres_net                   |     37.570  | (±54.4%) |    192.000  |  5.110 |
| fedora                         |     40.969  | (±21.1%) |    212.000  |  5.175 |
| fedora_net                     |     41.665  | (± 9.5%) |    212.000  |  5.088 |
| redis                          |     11.357k | (± 1.1%) |     57.225k |  5.039 |
| memory                         |     17.927k | (± 3.6%) |     91.320k |  5.094 |
| **member_tests create_parent**                                             |||||
| active_record_mysql            |     10.908  | (±25.3%) |     56.000  |  5.134 |
| active_record_mysql_net        |      5.671  | (±17.4%) |     29.000  |  5.114 |
| active_record_postgres         |     15.179  | (±28.9%) |     76.000  |  5.007 |
| active_record_postgres_net     |      5.000  | (±18.9%) |     26.000  |  5.200 |
| active_record_sqlite           |      4.176  | (±23.4%) |     21.000  |  5.029 |
| postgres                       |     77.968  | (±17.9%) |    392.000  |  5.028 |
| postgres_net                   |     34.427  | (±26.0%) |    174.000  |  5.054 |
| fedora                         |      3.784  | (±25.8%) |     20.000  |  5.285 |
| fedora_net                     |      3.172  | (± 0.0%) |     16.000  |  5.045 |
| redis                          |      1.748k | (±13.3%) |      8.750k |  5.007 |
| memory                         |      3.391k | (±13.3%) |     17.056k |  5.029 |
| **member_tests reload_parent**                                             |||||
| active_record_mysql            |      1.374k | (±18.6%) |      6.966k |  5.070 |
| active_record_mysql_net        |    350.588  | (± 8.2%) |      1.768k |  5.043 |
| active_record_postgres         |      1.227k | (±14.8%) |      6.248k |  5.093 |
| active_record_postgres_net     |    307.259  | (± 6.5%) |      1.548k |  5.038 |
| active_record_sqlite           |      1.443k | (±16.8%) |      7.248k |  5.023 |
| postgres                       |      1.050k | (±17.7%) |      5.320k |  5.068 |
| postgres_net                   |    302.054  | (±10.8%) |      1.530k |  5.065 |
| fedora                         |      4.179  | (±23.5%) |     21.000  |  5.025 |
| fedora_net                     |      3.830  | (± 0.0%) |     20.000  |  5.221 |
| redis                          |      5.314k | (±19.2%) |     26.946k |  5.070 |
| memory                         |    531.712k | (± 6.5%) |      2.691M |  5.061 |
| **member_tests update_child**                                              |||||
| active_record_mysql            |     25.109  | (±38.3%) |    126.000  |  5.018 |
| active_record_mysql_net        |     17.913  | (±26.6%) |     90.000  |  5.024 |
| active_record_postgres         |     73.142  | (±27.8%) |    366.000  |  5.004 |
| active_record_postgres_net     |     33.444  | (±28.4%) |    168.000  |  5.023 |
| active_record_sqlite           |     16.272  | (±38.3%) |     82.000  |  5.039 |
| postgres                       |     88.518  | (± 8.9%) |    448.000  |  5.061 |
| postgres_net                   |     60.986  | (±31.8%) |    308.000  |  5.050 |
| fedora                         |     58.816  | (±13.2%) |    295.000  |  5.016 |
| fedora_net                     |     48.546  | (± 6.2%) |    244.000  |  5.026 |
| redis                          |      5.650k | (±14.8%) |     28.726k |  5.084 |
| memory                         |     10.149k | (± 8.4%) |     50.800k |  5.005 |
| **member_tests update_parent**                                             |||||
| active_record_mysql            |     15.329  | (±33.6%) |     77.000  |  5.023 |
| active_record_mysql_net        |     11.897  | (±23.3%) |     60.000  |  5.043 |
| active_record_postgres         |     45.885  | (±41.8%) |    230.000  |  5.013 |
| active_record_postgres_net     |     26.230  | (±33.8%) |    132.000  |  5.032 |
| active_record_sqlite           |     10.533  | (±31.9%) |     53.000  |  5.032 |
| postgres                       |     74.944  | (±19.4%) |    385.000  |  5.137 |
| postgres_net                   |     31.211  | (±28.7%) |    159.000  |  5.094 |
| fedora                         |      1.393  | (± 0.0%) |      7.000  |  5.027 |
| fedora_net                     |      1.280  | (± 0.0%) |      7.000  |  5.469 |
| redis                          |      2.160k | (±12.5%) |     10.865k |  5.031 |
| memory                         |      4.864k | (±13.8%) |     24.480k |  5.033 |
| **member_tests one_more_page**                                             |||||
| active_record_mysql            |     10.432  | (±18.6%) |     53.000  |  5.081 |
| active_record_mysql_net        |      7.169  | (±13.6%) |     36.000  |  5.021 |
| active_record_postgres         |     26.558  | (±30.7%) |    133.000  |  5.008 |
| active_record_postgres_net     |     16.992  | (±35.8%) |     85.000  |  5.002 |
| active_record_sqlite           |      5.572  | (±38.6%) |     28.000  |  5.026 |
| postgres                       |     73.336  | (±20.7%) |    372.000  |  5.073 |
| postgres_net                   |     34.795  | (±25.6%) |    174.000  |  5.001 |
| fedora                         |      1.378  | (± 0.0%) |      7.000  |  5.079 |
| fedora_net                     |      1.292  | (± 0.0%) |      7.000  |  5.417 |
| redis                          |      2.148k | (±12.9%) |     10.918k |  5.084 |
| memory                         |      4.552k | (±15.6%) |     23.136k |  5.083 |
| **member_tests remove_page**                                               |||||
| active_record_mysql            |     12.008  | (±31.1%) |     61.000  |  5.080 |
| active_record_mysql_net        |      7.157  | (±13.8%) |     36.000  |  5.030 |
| active_record_postgres         |     31.712  | (±40.8%) |    159.000  |  5.014 |
| active_record_postgres_net     |     15.220  | (±45.3%) |     78.000  |  5.125 |
| active_record_sqlite           |      6.532  | (±36.8%) |     33.000  |  5.052 |
| postgres                       |     72.308  | (±22.7%) |    364.000  |  5.034 |
| postgres_net                   |     30.426  | (±33.0%) |    153.000  |  5.029 |
| fedora                         |      1.453  | (± 0.0%) |      8.000  |  5.507 |
| fedora_net                     |      1.425  | (± 0.0%) |      8.000  |  5.614 |
| redis                          |      4.115k | (±15.1%) |     20.604k |  5.006 |
| memory                         |      6.860k | (± 9.7%) |     34.578k |  5.041 |
| **member_tests find_parents**                                              |||||
| active_record_mysql            |    389.450  | (±16.7%) |      2.028k |  5.207 |
| active_record_mysql_net        |    171.113  | (± 8.1%) |    867.000  |  5.067 |
| active_record_postgres         |    404.434  | (±13.4%) |      2.058k |  5.089 |
| active_record_postgres_net     |    202.517  | (± 5.9%) |      1.026k |  5.066 |
| active_record_sqlite           |    461.972  | (±15.3%) |      2.346k |  5.078 |
| postgres                       |      1.699k | (±13.7%) |      8.496k |  5.002 |
| postgres_net                   |    516.733  | (±13.5%) |      2.585k |  5.003 |
| fedora                         |      4.313  | (±22.8%) |     22.000  |  5.100 |
| fedora_net                     |      4.306  | (± 0.0%) |     22.000  |  5.109 |
| redis                          |      0.269  | (± 0.0%) |      2.000  |  7.434 |
| memory                         |      0.999  | (± 0.0%) |      5.000  |  5.006 |
| **member_tests find_members**                                              |||||
| active_record_mysql            |     42.144  | (±17.6%) |    216.000  |  5.125 |
| active_record_mysql_net        |     33.113  | (±11.9%) |    166.000  |  5.013 |
| active_record_postgres         |     43.520  | (±19.3%) |    220.000  |  5.055 |
| active_record_postgres_net     |     25.382  | (±11.7%) |    128.000  |  5.043 |
| active_record_sqlite           |     41.242  | (±18.2%) |    208.000  |  5.043 |
| postgres                       |     67.450  | (±18.1%) |    342.000  |  5.070 |
| postgres_net                   |     49.893  | (±11.9%) |    250.000  |  5.011 |
| fedora                         |      0.747  | (± 0.0%) |      4.000  |  5.357 |
| fedora_net                     |      0.621  | (± 0.0%) |      4.000  |  6.441 |
| redis                          |    179.542  | (±18.9%) |    901.000  |  5.018 |
| memory                         |     10.542k | (± 7.7%) |     53.600k |  5.085 |
| **alternate_id_tests create**                                              |||||
| active_record_mysql            |     26.556  | (±44.9%) |    134.000  |  5.046 |
| active_record_mysql_net        |     15.806  | (±29.7%) |     80.000  |  5.061 |
| active_record_postgres         |     52.239  | (±38.5%) |    264.000  |  5.054 |
| active_record_postgres_net     |     38.085  | (±19.0%) |    192.000  |  5.041 |
| active_record_sqlite           |     18.642  | (±29.0%) |     94.000  |  5.042 |
| postgres                       |     79.378  | (±21.4%) |    400.000  |  5.039 |
| postgres_net                   |     43.326  | (±41.6%) |    220.000  |  5.078 |
| fedora                         |     14.565  | (± 6.8%) |     73.000  |  5.012 |
| fedora_net                     |     10.392  | (± 9.5%) |     52.000  |  5.004 |
| memory                         |      3.957k | (±10.2%) |     19.968k |  5.047 |
| **alternate_id_tests find**                                                |||||
| active_record_mysql            |    984.839  | (± 5.0%) |      4.992k |  5.069 |
| active_record_mysql_net        |    293.128  | (± 3.7%) |      1.485k |  5.066 |
| active_record_postgres         |      1.057k | (± 4.9%) |      5.300k |  5.016 |
| active_record_postgres_net     |    338.064  | (± 8.8%) |      1.715k |  5.073 |
| active_record_sqlite           |      1.212k | (± 5.3%) |      6.100k |  5.035 |
| postgres                       |      2.241k | (± 5.3%) |     11.280k |  5.034 |
| postgres_net                   |    587.504  | (±11.4%) |      2.970k |  5.055 |
| fedora                         |     40.769  | (± 4.9%) |    208.000  |  5.102 |
| fedora_net                     |     31.618  | (± 6.3%) |    159.000  |  5.029 |
| memory                         |     20.273  | (± 4.9%) |    102.000  |  5.031 |
