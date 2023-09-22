system("echo \'yes\'|cpan App::cpanminus");
system("cpanm Env::Modify --force");
system("cpanm Parallel::ForkManager --force");
system("cpanm Expect --force");
system("cpanm Statistics::Descriptive --force");
system("cpanm MCE::Shared --force");
